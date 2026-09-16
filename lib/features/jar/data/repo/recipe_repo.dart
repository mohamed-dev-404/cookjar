// Abstract repository interface for recipe data in the CookJar feature.
//
// [JarCubit] depends on this abstraction, never on [RecipeRepoImpl] directly.
// This boundary makes the cubit independently testable: in tests a fake
// implementation can be substituted without touching network code.
//
// The repository's sole responsibility is fetching recipes from the API and
// returning them as a typed result. Random selection from the list is the
// responsibility of [JarCubit].

import 'package:cookjar/core/models/recipe_details_model.dart';
import 'package:dartz/dartz.dart';

/// Provides access to the recipe data source.
///
/// Returns `Either<String, List<RecipeModel>>`:
/// - `Right(recipes)` — successful fetch, containing the full recipe list.
/// - `Left(message)` — failure, containing a human-readable error message.
///
/// Callers must not assume a specific list length or ordering.
abstract class RecipeRepo {
  /// Fetches the full recipe list from the remote data source.
  ///
  /// Each call performs a fresh network request — no caching is applied.
  /// This is intentional: the CookJar product requires a fresh request for
  /// every recipe generation and re-shake.
  Future<Either<String, List<RecipeModel>>> getRecipes();
}
