import 'package:cookjar/features/recipe_details/data/models/recipe_details_model.dart';
import 'package:dartz/dartz.dart';

abstract class SavedRepo {
  /// Saves [recipe] to local storage.
  ///
  /// Returns [Right(null)] on success.
  /// Returns [Left(errorMessage)] when the operation fails.
  Future<Either<String, void>> saveRecipe(RecipeModel recipe);

  /// Returns all locally saved recipes.
  ///
  /// Returns [Right(recipes)] on success (may be an empty list).
  /// Returns [Left(errorMessage)] when the operation fails.
  Future<Either<String, List<RecipeModel>>> getSavedRecipes();
}
