import 'package:flutter/foundation.dart';
import 'package:cookjar/features/recipe_details/data/models/recipe_details_model.dart';

@immutable
sealed class RecipeDetailsState {
  const RecipeDetailsState();
}

final class RecipeDetailsInitial extends RecipeDetailsState {
  const RecipeDetailsInitial();
}

final class RecipeDetailsLoading extends RecipeDetailsState {
  const RecipeDetailsLoading();
}

final class RecipeDetailsLoaded extends RecipeDetailsState {
  final RecipeModel recipe;
  final bool isFavorite;

  const RecipeDetailsLoaded({required this.recipe, this.isFavorite = false});

  RecipeDetailsLoaded copyWith({RecipeModel? recipe, bool? isFavorite}) {
    return RecipeDetailsLoaded(
      recipe: recipe ?? this.recipe,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

final class RecipeDetailsError extends RecipeDetailsState {
  final String errorMessage;

  const RecipeDetailsError({required this.errorMessage});
}
