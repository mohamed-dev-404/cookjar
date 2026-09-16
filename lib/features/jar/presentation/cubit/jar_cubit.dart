// Orchestrates the semantic state transitions for the CookJar feature.
//
// This Cubit owns the high-level lifecycle:
//   idle → shaking → openingLid → revealingPaper → revealingRecipe → showingRecipe
//   showingRecipe → closing → idle
//
// Recipe generation responsibilities:
//   - On play(), [_generateRecipe()] is fired concurrently with the animation.
//   - The animation starts immediately regardless of API result (Section 17 rule).
//   - [RecipeRepo.getRecipes()] returns the full list; this Cubit selects one
//     randomly. Random selection belongs here, not in the repository.
//   - On success, [selectedRecipe] is stored in state so the reveal UI can
//     read it when the paper animation completes.
//   - On failure, [generationError] is stored; the animation continues and the
//     error is surfaced after the reveal phase.
//
// Frame-level animation progress is NOT stored here — that belongs to the
// AnimationController layer. Cubit emits only on meaningful phase changes.
//
// A generation counter prevents stale async completions from mutating state
// after a newer sequence has already begun.

// ignore_for_file: prefer_initializing_formals

import 'dart:math';

import 'package:cookjar/features/recipe_details/data/models/recipe_details_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/recipe_repo.dart';
import 'jar_state.dart';

class JarCubit extends Cubit<JarState> {
  final RecipeRepo _recipeRepo;

  JarCubit({required RecipeRepo recipeRepo})
    : _recipeRepo = recipeRepo,
      super(const JarState());

  /// Incremented each time a new play or close sequence begins. Used by
  /// callers to detect whether their async continuation is still valid.
  int _generation = 0;

  /// Returns the current generation token.
  int get generation => _generation;

  // ── Opening lifecycle ──────────────────────────────────────────────────

  /// Attempts to transition to the shaking phase and fires recipe generation.
  ///
  /// Returns true if the transition was allowed (jar was idle), false if it
  /// was ignored (jar is already active).
  ///
  /// Recipe generation begins concurrently with the animation — the animation
  /// does NOT wait for the API response. This satisfies the product rule that
  /// the jar animation plays even when the API is slow or fails.
  bool play() {
    if (state.status != JarStatus.idle) return false;

    _generation++;

    // Clear any previous recipe/error before starting a new generation.
    emit(
      state.copyWith(
        status: JarStatus.shaking,
        clearSelectedRecipe: true,
        clearGenerationError: true,
      ),
    );

    // Fire concurrently — do not await here.
    _generateRecipe(_generation);

    return true;
  }

  /// Fetches the recipe list and randomly selects one recipe for this generation.
  ///
  /// Stale completions are discarded via the [capturedGeneration] guard.
  /// The animation sequence does not depend on this completing before any
  /// particular phase.
  Future<void> _generateRecipe(int capturedGeneration) async {
    final result = await _recipeRepo.getRecipes();

    // Discard if a newer sequence has started or the cubit is closed.
    if (isClosed || capturedGeneration != _generation) return;

    result.fold(
      (errorMessage) {
        emit(state.copyWith(generationError: errorMessage));
      },
      (recipes) {
        if (recipes.isEmpty) {
          emit(
            state.copyWith(
              generationError: 'No recipes were returned by the server.',
            ),
          );
          return;
        }

        final RecipeModel selected = recipes[Random().nextInt(recipes.length)];
        emit(state.copyWith(selectedRecipe: selected));
      },
    );
  }

  /// Called when the shake animation has fully completed.
  void onShakeCompleted(int completedGeneration) {
    if (completedGeneration != _generation) return;
    if (state.status != JarStatus.shaking) return;

    emit(state.copyWith(status: JarStatus.openingLid));
  }

  /// Called when the lid-opening animation has fully completed.
  void onLidOpenCompleted(int completedGeneration) {
    if (completedGeneration != _generation) return;
    if (state.status != JarStatus.openingLid) return;

    emit(state.copyWith(status: JarStatus.revealingPaper));
  }

  /// Called when the paper-reveal animation has fully completed.
  void onPaperRevealCompleted(int completedGeneration) {
    if (completedGeneration != _generation) return;
    if (state.status != JarStatus.revealingPaper) return;

    emit(state.copyWith(status: JarStatus.revealingRecipe));
  }

  /// Called when the recipe-reveal animation has fully completed.
  ///
  /// Previously named `onQuoteRevealCompleted`.
  void onRecipeRevealCompleted(int completedGeneration) {
    if (completedGeneration != _generation) return;
    if (state.status != JarStatus.revealingRecipe) return;

    emit(state.copyWith(status: JarStatus.showingRecipe));
  }

  // ── Closing lifecycle ──────────────────────────────────────────────────

  /// Begins the animated close sequence from [JarStatus.showingRecipe].
  ///
  /// Returns true if the transition was allowed, false if ignored.
  bool startClose() {
    if (state.status != JarStatus.showingRecipe) return false;

    _generation++;
    emit(state.copyWith(status: JarStatus.closing));
    return true;
  }

  /// Called when the entire animated close sequence has completed.
  /// Transitions to idle so the jar is ready for a new play cycle.
  void onCloseCompleted(int completedGeneration) {
    if (completedGeneration != _generation) return;
    if (state.status != JarStatus.closing) return;

    emit(
      state.copyWith(
        status: JarStatus.idle,
        clearSelectedRecipe: true,
        clearGenerationError: true,
      ),
    );
  }

  /// Hard reset — instantly returns to idle from any state.
  /// Used by the animation layer for non-animated resets (e.g. during
  /// an active opening sequence that should be cancelled).
  void hardReset() {
    _generation++;
    emit(const JarState(status: JarStatus.idle));
  }
}
