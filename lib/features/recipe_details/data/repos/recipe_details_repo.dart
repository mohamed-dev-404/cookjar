import 'package:cookjar/features/recipe_details/data/models/recipe_details_model.dart';

abstract class RecipeDetailsRepo {
  Future<RecipeModel> getRecipeDetails({required int recipeId});
}
