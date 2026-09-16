// Defines the strongly typed state for the CookJar feature.
//
// This file separates the state representation from the logic. The state uses
// an immutable class containing a [JarStatus] enum plus optional recipe and
// error fields. This allows [BlocSelector] and [context.select] to rebuild
// only the specific parts of the jar UI that depend on a particular stage.
//
// Migration note: `revealingQuote` → `revealingRecipe`,
//                 `showingQuote`   → `showingRecipe`.

import 'package:cookjar/core/models/recipe_details_model.dart';

/// Represents the high-level phases of the jar's animation and recipe lifecycle.
enum JarStatus {
  idle,
  shaking,
  openingLid,
  revealingPaper,

  /// The paper has fully risen; the recipe content is now animating into view.
  revealingRecipe,

  /// The recipe is fully visible and remains on screen until the user closes it.
  showingRecipe,

  closing,
}

/// The state emitted by [JarCubit].
///
/// Fields:
/// - [status] — the current animation/lifecycle phase.
/// - [selectedRecipe] — the recipe chosen for the current generation; null
///   until the API call completes successfully.
/// - [generationError] — human-readable error message when the API call fails;
///   null on success or before any generation attempt.
class JarState {
  /// The current phase of the animation and recipe lifecycle.
  final JarStatus status;

  /// The randomly selected recipe for the current CookJar generation.
  ///
  /// Non-null once the API call has succeeded and a recipe has been selected.
  /// Null during idle, loading, or on API failure.
  final RecipeModel? selectedRecipe;

  /// Human-readable error message when recipe generation fails.
  ///
  /// Non-null only when the API request returned an error. Null on success
  /// and during idle state.
  final String? generationError;

  const JarState({
    this.status = JarStatus.idle,
    this.selectedRecipe,
    this.generationError,
  });

  /// Creates a copy of this state with the given fields replaced.
  JarState copyWith({
    JarStatus? status,
    RecipeModel? selectedRecipe,
    String? generationError,
    bool clearSelectedRecipe = false,
    bool clearGenerationError = false,
  }) {
    return JarState(
      status: status ?? this.status,
      selectedRecipe: clearSelectedRecipe
          ? null
          : (selectedRecipe ?? this.selectedRecipe),
      generationError: clearGenerationError
          ? null
          : (generationError ?? this.generationError),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is JarState &&
        other.status == status &&
        other.selectedRecipe == selectedRecipe &&
        other.generationError == generationError;
  }

  @override
  int get hashCode => Object.hash(status, selectedRecipe, generationError);
}
