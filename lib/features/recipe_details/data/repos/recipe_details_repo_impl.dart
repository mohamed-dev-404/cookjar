import 'package:cookjar/features/recipe_details/data/data_source/recipe_details_remote_data_source.dart';
import 'package:cookjar/core/models/recipe_details_model.dart';
import 'package:cookjar/features/recipe_details/data/repos/recipe_details_repo.dart';

class RecipeDetailsRepoImpl implements RecipeDetailsRepo {
  final RecipeDetailsRemoteDataSource remoteDataSource;

  const RecipeDetailsRepoImpl({required this.remoteDataSource});

  @override
  Future<RecipeModel> getRecipeDetails({required int recipeId}) {
    return remoteDataSource.getRecipeDetails(recipeId: recipeId);
  }
}
