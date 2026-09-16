// The main public entry point for the CookJar feature.
//
// Responsibilities:
//  - Expose [JarController] as the parent-facing interaction API.
//  - Own the [JarCubit], four AnimationControllers (shake, lid, paper, recipe),
//    and the [JarAudioService].
//  - Accept [RecipeRepo] and wire it into [JarCubit] via constructor injection.
//  - Expose [onCookNow], [onAddToFavorite], and [onReshake] callbacks so the
//    parent can react to recipe-related user actions without CookJar owning
//    navigation or persistence concerns.
//  - Compose the visual layers in a Stack with proper z-ordering.
//  - Keep the selected paper hidden during idle state.
//  - Keep the recipe content hidden until the paper has fully settled.
//  - Drive each animation phase via AnimatedBuilder so static layers
//    are never rebuilt during animation frames.
//
// Architecture — opening:
//  controller.play() → Cubit(shaking) + _generateRecipe() [concurrent]
//    → shakeController.forward()
//    → completion → Cubit(openingLid) → lidController.forward()
//    → completion → Cubit(revealingPaper) → paperController.forward()
//    → completion → Cubit(revealingRecipe) → recipeRevealController.forward()
//    → completion → Cubit(showingRecipe) — recipe persists until close
//
// Architecture — closing:
//  controller.close() / paper tap → Cubit(closing)
//    → recipeRevealController.reverse() → paperController.reverse()
//    → lidController.reverse() → deterministic reset → Cubit(idle)
//
// Audio is triggered at each semantic phase boundary by the orchestration
// layer. Visual widgets never import the audio service.

import 'package:cookjar/core/models/recipe_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../audio/jar_audio_service.dart';
import 'widgets/jar_constants.dart';
import '../view_model/jar_cubit.dart';
import '../view_model/jar_state.dart';
import '../../data/repo/recipe_repo.dart';
import 'widgets/jar_body.dart';
import 'widgets/jar_contents.dart';
import 'widgets/jar_lid.dart';
import 'widgets/recipe_result_card.dart';

// ---------------------------------------------------------------------------
// Public controller
// ---------------------------------------------------------------------------

/// Semantic controller for [AnimatedCookJar].
///
/// The parent calls [play] / [close] without knowing about internal mechanics.
/// Callbacks are detached on dispose to prevent retaining references to a
/// disposed widget state.
class JarController {
  VoidCallback? _playCallback;
  VoidCallback? _closeCallback;

  /// Starts the recipe-reveal animation sequence.
  /// Silently ignored if the jar is not idle.
  void play() => _playCallback?.call();

  /// Closes/resets the jar.
  void close() => _closeCallback?.call();

  void _attach({required VoidCallback onPlay, required VoidCallback onClose}) {
    _playCallback = onPlay;
    _closeCallback = onClose;
  }

  void _detach() {
    _playCallback = null;
    _closeCallback = null;
  }
}

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

/// A self-contained animated CookJar widget.
///
/// The jar shakes, opens its cork, and reveals a randomly selected recipe.
/// Recipe generation is handled internally via [RecipeRepo] — the parent does
/// not provide the recipe string.
///
/// Parent-facing callbacks:
/// - [onCookNow] — invoked with the selected [RecipeModel] when the user
///   chooses to cook the revealed recipe. Navigation is the parent's concern.
/// - [onAddToFavorite] — invoked with the selected [RecipeModel] when the
///   user saves a recipe to favorites. Persistence is the parent's concern.
/// - [onReshake] — invoked when the user requests a new recipe generation.
///   The re-shake sequence will be implemented in a later step.
///
/// All three callbacks are nullable; omitting them is safe during development.
class AnimatedCookJar extends StatefulWidget {
  /// Repository used to fetch the recipe list for each generation.
  ///
  /// The parent is responsible for constructing and providing this so [AnimatedCookJar]
  /// remains portable and testable independently of the HTTP stack.
  final RecipeRepo recipeRepo;

  /// Whether to display recipe text in right-to-left direction.
  final bool isRtl;

  /// Semantic controller for triggering play and close from the parent.
  final JarController controller;

  /// Called with the selected [RecipeModel] when the user chooses to cook now.
  ///
  /// Navigation to the recipe detail screen is the parent's responsibility.
  /// Not yet invoked — the action button UI is a later implementation step.
  final void Function(RecipeModel recipe)? onCookNow;

  /// Called with the selected [RecipeModel] when the user adds it to favorites.
  ///
  /// Hive persistence is the parent's responsibility.
  /// Not yet invoked — the action button UI is a later implementation step.
  final void Function(RecipeModel recipe)? onAddToFavorite;

  /// Called when the user requests a new random recipe (re-shake).
  ///
  /// The re-shake animation sequence is a later implementation step.
  final VoidCallback? onReshake;

  const AnimatedCookJar({
    super.key,
    required this.recipeRepo,
    required this.isRtl,
    required this.controller,
    this.onCookNow,
    this.onAddToFavorite,
    this.onReshake,
  });

  @override
  State<AnimatedCookJar> createState() => _AnimatedCookJarState();
}

class _AnimatedCookJarState extends State<AnimatedCookJar>
    with TickerProviderStateMixin {
  late final JarCubit _cubit;
  late final JarAudioService _audio;

  // ── Animation controllers ──────────────────────────────────────────────
  late final AnimationController _shakeController;
  late final AnimationController _lidController;
  late final AnimationController _paperController;
  late final AnimationController _recipeRevealController;

  // ── Derived shake animations ───────────────────────────────────────────
  late final Animation<double> _shakeTranslation;
  late final Animation<double> _shakeRotation;

  // ── Derived lid animations ─────────────────────────────────────────────
  late final Animation<double> _lidTranslationY;
  late final Animation<double> _lidRotation;

  // ── Derived paper animations ───────────────────────────────────────────
  late final Animation<double> _paperTranslationY;
  late final Animation<double> _paperScale;
  late final Animation<double> _paperRotation;
  late final Animation<double> _paperOpacity;

  // ── Derived recipe-text reveal animations ─────────────────────────────
  late final Animation<double> _recipeOpacity;
  late final Animation<double> _recipeScale;
  late final Animation<double> _recipeOffsetY;

  bool _isReshakePending = false;

  @override
  void initState() {
    super.initState();

    _cubit = JarCubit(recipeRepo: widget.recipeRepo);
    _audio = JarAudioService();

    // Shake — 3 seconds
    _shakeController = AnimationController(
      vsync: this,
      duration: JarConstants.shakeDuration,
    );

    // Lid — 0.6 seconds (opening); duration is swapped for closing
    _lidController = AnimationController(
      vsync: this,
      duration: JarConstants.lidOpenDuration,
    );

    // Paper — 1 second (opening); duration is swapped for closing
    _paperController = AnimationController(
      vsync: this,
      duration: JarConstants.paperRevealDuration,
    );

    // Recipe text — 0.8 seconds (reveal); duration is swapped for closing
    _recipeRevealController = AnimationController(
      vsync: this,
      duration: JarConstants.quoteRevealDuration,
    );

    _initShakeAnimations();
    _initLidAnimations();
    _initPaperAnimations();
    _initRecipeRevealAnimations();

    widget.controller._attach(onPlay: _handlePlay, onClose: _handleClose);
  }

  // ── Shake TweenSequence ──────────────────────────────────────────────
  void _initShakeAnimations() {
    final double baseA = JarConstants.shakeAmplitude;
    final double baseR = JarConstants.shakeRotationAmplitude;

    final List<TweenSequenceItem<double>> tItems = [];
    final List<TweenSequenceItem<double>> rItems = [];

    const int totalSwings = JarConstants.shakeOscillations;

    double currentA = 0.0;
    double currentR = 0.0;

    for (int i = 0; i <= totalSwings; i++) {
      double envelope = 1.0;
      if (i == 0 || i == totalSwings) {
        envelope = 0.0;
      } else if (i < 3) {
        envelope = i / 3.0;
      } else {
        envelope = 1.0 - ((i - 3) / (totalSwings - 3));
      }

      final double nextA = (i % 2 == 0 ? 1 : -1) * baseA * envelope;
      final double nextR = (i % 2 == 0 ? 1 : -1) * baseR * envelope;

      if (i > 0) {
        final double weight = (i == totalSwings || i == 1) ? 1.0 : 2.0;
        tItems.add(
          TweenSequenceItem(
            tween: Tween(
              begin: currentA,
              end: nextA,
            ).chain(CurveTween(curve: Curves.easeInOutSine)),
            weight: weight,
          ),
        );
        rItems.add(
          TweenSequenceItem(
            tween: Tween(
              begin: currentR,
              end: nextR,
            ).chain(CurveTween(curve: Curves.easeInOutSine)),
            weight: weight,
          ),
        );
      }

      currentA = nextA;
      currentR = nextR;
    }

    _shakeTranslation = TweenSequence<double>(tItems).animate(_shakeController);
    _shakeRotation = TweenSequence<double>(rItems).animate(_shakeController);
  }

  // ── Lid TweenSequence ──────────────────────────────────────────────────
  void _initLidAnimations() {
    _lidTranslationY = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: JarConstants.lidOpenTranslationY * 1.15,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 65,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: JarConstants.lidOpenTranslationY * 1.15,
          end: JarConstants.lidOpenTranslationY,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 35,
      ),
    ]).animate(_lidController);

    _lidRotation = Tween<double>(
      begin: 0.0,
      end: JarConstants.lidOpenRotation,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_lidController);
  }

  // ── Paper TweenSequence ────────────────────────────────────────────────
  void _initPaperAnimations() {
    _paperTranslationY = Tween<double>(
      begin: JarConstants.paperStartOffsetY,
      end: 0.0,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_paperController);

    _paperScale = Tween<double>(
      begin: JarConstants.paperStartScale,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_paperController);

    _paperRotation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: JarConstants.paperRevealRotation,
          end: -JarConstants.paperRevealRotation * 0.4,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: -JarConstants.paperRevealRotation * 0.4,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
    ]).animate(_paperController);

    _paperOpacity = Tween<double>(begin: 0.0, end: 1.0)
        .chain(
          CurveTween(curve: const Interval(0.0, 0.3, curve: Curves.easeIn)),
        )
        .animate(_paperController);
  }

  // ── Recipe Text Reveal ─────────────────────────────────────────────────
  void _initRecipeRevealAnimations() {
    _recipeOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.easeIn)).animate(_recipeRevealController);

    _recipeScale = Tween<double>(
      begin: JarConstants.quoteRevealStartScale,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_recipeRevealController);

    _recipeOffsetY = Tween<double>(
      begin: JarConstants.quoteRevealStartOffsetY,
      end: 0.0,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_recipeRevealController);
  }

  // ── Play orchestration ─────────────────────────────────────────────────
  void _handlePlay() {
    final bool allowed = _cubit.play();
    if (!allowed) return;

    final int generation = _cubit.generation;

    // Phase 1: Shake + shake audio
    _audio.playShake(JarConstants.shakeAudioAsset);
    _shakeController.reset();
    _shakeController.forward().whenCompleteOrCancel(() {
      if (!mounted || generation != _cubit.generation) return;
      _cubit.onShakeCompleted(generation);

      // Phase 2: Lid opens + cork audio
      _audio.playCork(JarConstants.corkAudioAsset);
      _lidController.reset();
      _lidController.forward().whenCompleteOrCancel(() {
        if (!mounted || generation != _cubit.generation) return;
        _cubit.onLidOpenCompleted(generation);

        // Phase 3: Paper reveal + paper audio
        _audio.playPaper(JarConstants.paperAudioAsset);
        _paperController.reset();
        _paperController.forward().whenCompleteOrCancel(() {
          if (!mounted || generation != _cubit.generation) return;
          _cubit.onPaperRevealCompleted(generation);

          // Phase 4: Recipe text reveal
          _recipeRevealController.reset();
          _recipeRevealController.forward().whenCompleteOrCancel(() {
            if (!mounted || generation != _cubit.generation) return;
            _cubit.onRecipeRevealCompleted(generation);
          });
        });
      });
    });
  }

  // ── Close orchestration ────────────────────────────────────────────────
  // Called by controller.close() AND paper tap.
  //
  // Routing:
  //  - showingRecipe → animated close
  //  - closing       → ignore (already closing)
  //  - idle          → ignore (nothing to close)
  //  - any other     → hard reset (cancel active opening)
  void _handleClose() {
    final JarStatus status = _cubit.state.status;

    if (status == JarStatus.showingRecipe) {
      _startAnimatedClose();
    } else if (status == JarStatus.closing || status == JarStatus.idle) {
      return;
    } else {
      _hardReset();
    }
  }

  // Called only by paper tap — only triggers from showingRecipe.
  void _handlePaperTap() {
    if (_cubit.state.status == JarStatus.showingRecipe) {
      _startAnimatedClose();
    }
  }

  void _handleReshake() {
    if (_cubit.state.status != JarStatus.showingRecipe) return;
    widget.onReshake?.call();

    _isReshakePending = true;
    _startAnimatedClose();
  }

  /// Animated close: recipe fades → paper returns → lid closes → idle.
  ///
  /// Reuses the existing controllers by calling .reverse() with shorter
  /// durations. After the sequence, opening durations are restored and
  /// all controllers are reset to value 0 for the next play cycle.
  void _startAnimatedClose() {
    final bool allowed = _cubit.startClose();
    if (!allowed) return;

    final int generation = _cubit.generation;

    // Phase C1: Recipe text fades out
    _recipeRevealController.duration = JarConstants.quoteCloseDuration;
    _recipeRevealController.reverse().whenCompleteOrCancel(() {
      if (!mounted || generation != _cubit.generation) return;

      // Phase C2: Paper contracts and returns toward jar
      _paperController.duration = JarConstants.paperCloseDuration;
      _paperController.reverse().whenCompleteOrCancel(() {
        if (!mounted || generation != _cubit.generation) return;

        // Phase C3: Lid returns to resting position
        _lidController.duration = JarConstants.lidCloseDuration;
        _lidController.reverse().whenCompleteOrCancel(() {
          if (!mounted || generation != _cubit.generation) return;

          // Deterministic reset: restore durations and zero all controllers
          _restoreOpenDurations();
          _shakeController.reset();
          _lidController.reset();
          _paperController.reset();
          _recipeRevealController.reset();

          _cubit.onCloseCompleted(generation);

          if (_isReshakePending) {
            _isReshakePending = false;
            _handlePlay();
          }
        });
      });
    });
  }

  /// Hard reset — stops everything immediately and returns to idle.
  /// Used when close is requested during an active opening sequence.
  void _hardReset() {
    _isReshakePending = false;
    _audio.stopAll();
    _restoreOpenDurations();
    _shakeController.reset();
    _lidController.reset();
    _paperController.reset();
    _recipeRevealController.reset();
    _cubit.hardReset();
  }

  /// Restores all controller durations to their opening values so the
  /// next play cycle uses the correct timings.
  void _restoreOpenDurations() {
    _lidController.duration = JarConstants.lidOpenDuration;
    _paperController.duration = JarConstants.paperRevealDuration;
    _recipeRevealController.duration = JarConstants.quoteRevealDuration;
  }

  @override
  void didUpdateWidget(covariant AnimatedCookJar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller._detach();
      widget.controller._attach(onPlay: _handlePlay, onClose: _handleClose);
    }
  }

  @override
  void dispose() {
    widget.controller._detach();
    _shakeController.dispose();
    _lidController.dispose();
    _paperController.dispose();
    _recipeRevealController.dispose();
    _audio.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: GestureDetector(
        onTap: _handlePlay,
        behavior: HitTestBehavior.opaque,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // The logical bounding box that perfectly fits the jar and its animation.
            // By REDUCING these multipliers, we remove empty space around the jar,
            // which causes the FittedBox to scale the jar UP to a larger visual size on screen.
            final double logicalHeight = JarConstants.jarHeight * 1.65;
            final double logicalWidth = JarConstants.jarWidth * 1.45;

            Widget jarStack = Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Layer 1: Jar assembly (contents + glass + lid)
                _buildShakeLayer(),

                // Layer 2: Selected paper — foreground hero layer
                _buildPaperLayer(),
              ],
            );

            // By wrapping the logical scene in a FittedBox, the jar will
            // automatically scale up to fill large spaces and scale down
            // for small spaces, maintaining its proportions perfectly.
            return FittedBox(
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: logicalWidth,
                height: logicalHeight,
                child: jarStack,
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Shake layer ────────────────────────────────────────────────────────
  Widget _buildShakeLayer() {
    return AnimatedBuilder(
      animation: _shakeController,
      child: _buildJarAssemblyWithLid(),
      builder: (context, child) {
        return Transform(
          alignment: const Alignment(0, 0.8),
          transform: Matrix4.translationValues(_shakeTranslation.value, 0, 0)
            ..rotateZ(_shakeRotation.value),
          child: child,
        );
      },
    );
  }

  // ── Jar assembly with independently animated lid ───────────────────────
  Widget _buildJarAssemblyWithLid() {
    return SizedBox(
      width: JarConstants.jarWidth * 1.5,
      height: JarConstants.jarHeight + JarConstants.lidHeight + 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            child: JarContents(shakeAnimation: _shakeController),
          ),
          const Positioned(bottom: 0, child: JarBody()),
          Positioned(
            bottom: JarConstants.jarHeight - 20,
            child: AnimatedBuilder(
              animation: _lidController,
              child: const JarLid(),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.translationValues(
                    0,
                    _lidTranslationY.value,
                    0,
                  )..rotateZ(_lidRotation.value),
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── Paper layer ────────────────────────────────────────────────────────
  // Visible during: revealingPaper, revealingRecipe, showingRecipe, closing.
  // Hidden during: idle, shaking, openingLid.
  //
  // A GestureDetector on the paper intercepts taps to trigger close
  // when the recipe is showing. It also absorbs taps during other visible
  // phases so they don't propagate to the jar's play GestureDetector.
  Widget _buildPaperLayer() {
    return BlocSelector<JarCubit, JarState, bool>(
      selector: (state) =>
          state.status == JarStatus.revealingPaper ||
          state.status == JarStatus.revealingRecipe ||
          state.status == JarStatus.showingRecipe ||
          state.status == JarStatus.closing,
      builder: (context, isVisible) {
        if (!isVisible) return const SizedBox.shrink();

        return AnimatedBuilder(
          animation: _paperController,
          child: GestureDetector(
            onTap: _handlePaperTap,
            behavior: HitTestBehavior.deferToChild,
            child: _buildPaperWithRecipeReveal(),
          ),
          builder: (context, child) {
            return Positioned.fill(
              child: Center(
                child: Transform(
                  alignment: Alignment.center,
                  transform:
                      Matrix4.translationValues(0, _paperTranslationY.value, 0)
                        ..rotateZ(_paperRotation.value)
                        ..scaleByDouble(
                          _paperScale.value,
                          _paperScale.value,
                          1.0,
                          1.0,
                        ),
                  child: Opacity(
                    opacity: _paperOpacity.value.clamp(0.0, 1.0),
                    child: child,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ── Paper body with animated recipe result ────────────────────────────
  Widget _buildPaperWithRecipeReveal() {
    return AnimatedBuilder(
      animation: _recipeRevealController,
      child: BlocSelector<JarCubit, JarState, RecipeModel?>(
        selector: (state) => state.selectedRecipe,
        builder: (context, recipe) => RecipeResultCard(
          recipe: recipe,
          isRtl: widget.isRtl,
          onCookNow: recipe != null
              ? () => widget.onCookNow?.call(recipe)
              : null,
          onAddToFavorite: recipe != null
              ? () => widget.onAddToFavorite?.call(recipe)
              : null,
          onReshake: _handleReshake,
        ),
      ),
      builder: (context, child) {
        return Opacity(
          opacity: _recipeOpacity.value.clamp(0.0, 1.0),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.translationValues(0, _recipeOffsetY.value, 0)
              ..scaleByDouble(_recipeScale.value, _recipeScale.value, 1.0, 1.0),
            child: child,
          ),
        );
      },
    );
  }
}
