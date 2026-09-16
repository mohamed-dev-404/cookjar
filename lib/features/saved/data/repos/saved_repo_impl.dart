import 'package:cookjar/core/errors/exceptions/cache_exception.dart';
import 'package:cookjar/core/models/recipe_details_model.dart';
import 'package:cookjar/features/saved/data/data_sources/saved_local_data_source.dart';
import 'package:cookjar/features/saved/data/repos/saved_repo.dart';
import 'package:dartz/dartz.dart';

class SavedRepoImpl implements SavedRepo {
  SavedRepoImpl({required this.localDataSource});

  final SavedLocalDataSource localDataSource;

  @override
  Future<Either<String, void>> saveRecipe(RecipeModel recipe) async {
    try {
      await localDataSource.saveRecipe(recipe);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<RecipeModel>>> getSavedRecipes() async {
    try {
      final recipes = await localDataSource.getSavedRecipes();
      return Right(recipes);
    } on CacheException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> removeRecipe(int recipeId) async {
    try {
      await localDataSource.removeRecipe(recipeId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
