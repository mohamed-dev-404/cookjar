import 'package:cookjar/core/models/recipe_details_model.dart';

abstract class RecipeDetailsRepo {
  Future<RecipeModel> getRecipeDetails({required int recipeId});
}
