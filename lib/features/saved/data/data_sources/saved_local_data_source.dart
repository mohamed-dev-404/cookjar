import 'package:cookjar/core/errors/exceptions/cache_exception.dart';
import 'package:cookjar/core/errors/models/error_model.dart';
import 'package:cookjar/core/services/cache/hive/hive_service.dart';
import 'package:cookjar/core/models/recipe_details_model.dart';

abstract class SavedLocalDataSource {
  Future<void> saveRecipe(RecipeModel recipe);
  Future<List<RecipeModel>> getSavedRecipes();
  bool containsRecipe(int id);
  Future<void> removeRecipe(int id);
}

class SavedLocalDataSourceImpl implements SavedLocalDataSource {
  SavedLocalDataSourceImpl({required this.hiveService});

  final HiveService hiveService;

  @override
  Future<void> saveRecipe(RecipeModel recipe) async {
    try {
      await hiveService.put(hiveService.recipesBox, recipe.id, recipe);
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to save recipe to local storage: $e',
        ),
      );
    }
  }

  @override
  Future<List<RecipeModel>> getSavedRecipes() async {
    try {
      return hiveService.getAll(hiveService.recipesBox);
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to get saved recipes from local storage: $e',
        ),
      );
    }
  }

  @override
  bool containsRecipe(int id) {
    try {
      return hiveService.containsKey(hiveService.recipesBox, id);
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to check recipe in local storage: $e',
        ),
      );
    }
  }

  @override
  Future<void> removeRecipe(int id) async {
    try {
      await hiveService.delete(hiveService.recipesBox, id);
    } catch (e) {
      throw CacheException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to remove recipe from local storage: $e',
        ),
      );
    }
  }
}
