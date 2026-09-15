import 'package:cookjar/features/recipe_details/data/models/recipe_details_model.dart';

abstract class RecipeDetailsRepo {
  Future<RecipeDetailsModel> getRecipeDetails({required int recipeId});
}
