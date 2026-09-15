import 'package:cookjar/core/services/network/api_consumer.dart';
import 'package:cookjar/features/recipe_details/data/models/recipe_details_model.dart';

abstract class RecipeDetailsRemoteDataSource {
  Future<RecipeDetailsModel> getRecipeDetails({required int recipeId});
}

class RecipeDetailsRemoteDataSourceImpl
    implements RecipeDetailsRemoteDataSource {
  final ApiConsumer apiConsumer;

  const RecipeDetailsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<RecipeDetailsModel> getRecipeDetails({required int recipeId}) async {
    final response = await apiConsumer.get('/recipes/$recipeId');
    return RecipeDetailsModel.fromJson(response as Map<String, dynamic>);
  }
}
