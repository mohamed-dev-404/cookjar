// Concrete [RecipeRepo] implementation that fetches recipes from the
// DummyJSON API via [ApiConsumer].
//
// Architectural responsibilities of this class:
//   - Issue the HTTP GET request via [ApiConsumer].
//   - Parse the top-level `recipes` array into [List<RecipeModel>].
//   - Map network/server failures to a [Left] with a human-readable message.
//   - Return a [Right] with the full recipe list on success.
//
// What this class does NOT do:
//   - Random selection — that is [JarCubit]'s responsibility.
//   - Caching — every call is a fresh request per the product requirement.
//   - Navigation or UI concerns.

import 'package:cookjar/core/constants/api_endpoints.dart';
import 'package:cookjar/core/errors/exceptions/api_exception.dart';
import 'package:cookjar/core/services/network/api_consumer.dart';
import 'package:cookjar/features/recipe_details/data/models/recipe_details_model.dart';
import 'package:dartz/dartz.dart';
import 'recipe_repo.dart';

/// [RecipeRepo] implementation backed by [ApiConsumer].
///
/// Depends on [ApiConsumer] rather than Dio directly, keeping the dependency
/// direction clean:
///
/// ```
/// RecipeRepoImpl → ApiConsumer → DioConsumer → HTTP → DummyJSON
/// ```
class RecipeRepoImpl implements RecipeRepo {
  final ApiConsumer _api;

  const RecipeRepoImpl(this._api);

  @override
  Future<Either<String, List<RecipeModel>>> getRecipes() async {
    try {
      final Map<String, dynamic> response = await _api.get(
        EndPoints.recipesEndpoint,
      );

      final dynamic rawList = response['recipes'];
      if (rawList is! List) {
        return const Left('Unexpected API response: missing "recipes" array.');
      }

      final List<RecipeModel> recipes = rawList
          .whereType<Map<String, dynamic>>()
          .map(RecipeModel.fromJson)
          .toList();

      return Right(recipes);
    } on ApiException catch (e) {
      return Left(e.errorModel.errorMessage); // failure case
    } catch (e) {
      return Left(e.toString()); // failure case
    }
  }
}
