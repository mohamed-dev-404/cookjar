import 'package:cookjar/core/services/network/api_consumer.dart';
import 'package:cookjar/core/models/recipe_details_model.dart';

abstract class RecipeDetailsRemoteDataSource {
  Future<RecipeModel> getRecipeDetails({required int recipeId});
}

class RecipeDetailsRemoteDataSourceImpl
    implements RecipeDetailsRemoteDataSource {
  final ApiConsumer apiConsumer;

  const RecipeDetailsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<RecipeModel> getRecipeDetails({required int recipeId}) async {
    final response = await apiConsumer.get('/recipes/$recipeId');
    return RecipeModel.fromJson(response as Map<String, dynamic>);
  }
}
