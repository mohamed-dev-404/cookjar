import 'package:cookjar/core/models/recipe_details_model.dart';

sealed class SavedRecipesState {
  const SavedRecipesState();
}

final class SavedRecipesInitial extends SavedRecipesState {
  const SavedRecipesInitial();
}

final class SavedRecipesLoading extends SavedRecipesState {
  const SavedRecipesLoading();
}

final class SavedRecipesSuccess extends SavedRecipesState {
  final List<RecipeModel> recipes;
  const SavedRecipesSuccess({required this.recipes});
}

final class SavedRecipesFailure extends SavedRecipesState {
  final String errorMessage;
  const SavedRecipesFailure({required this.errorMessage});
}
