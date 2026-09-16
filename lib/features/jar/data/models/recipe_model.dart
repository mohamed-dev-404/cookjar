// // The core domain model for a recipe in the CookJar feature.
// //
// // [RecipeModel] is an immutable value object representing a single recipe as
// // returned by the DummyJSON `/recipes` endpoint. It is the unit of data
// // consumed by [JarCubit] (selected randomly), surfaced to callbacks
// // (`onCookNow`, `onAddToFavorite`), and later displayed in the recipe result UI.
// //
// // Parsing is handled by [RecipeModel.fromJson]. All fields map directly to the
// // API response structure. The [image] field is a single URL extracted from the
// // first element of the API `images` array — the feature currently uses one image
// // per recipe. An empty or missing `images` array is handled gracefully by
// // defaulting to an empty string.
// //
// // This model is intentionally self-contained. It does not depend on Hive,
// // Dio, or any other infrastructure package so it remains reusable by the
// // future Favorites feature.

// /// A complete recipe domain object, matching the DummyJSON recipe structure.
// class RecipeModel {
//   /// Unique recipe identifier from the API.
//   final int id;

//   /// Display name of the recipe.
//   final String name;

//   /// Ordered list of ingredient strings.
//   final List<String> ingredients;

//   /// Ordered list of instruction step strings.
//   final List<String> instructions;

//   /// Estimated preparation time in minutes.
//   final int prepTimeMinutes;

//   /// Estimated cooking time in minutes.
//   final int cookTimeMinutes;

//   /// Number of servings the recipe yields.
//   final int servings;

//   /// Difficulty level as a string (e.g., `"Easy"`, `"Medium"`, `"Hard"`).
//   final String difficulty;

//   /// Cuisine type (e.g., `"Italian"`, `"Mexican"`).
//   final String cuisine;

//   /// Approximate calories per serving.
//   final int caloriesPerServing;

//   /// List of tags associated with the recipe (e.g., `["Breakfast", "Quick"]`).
//   final List<String> tags;

//   /// ID of the user who submitted the recipe.
//   final int userId;

//   /// URL of the recipe's primary image.
//   ///
//   /// The DummyJSON recipes API provides this as a direct string field.
//   /// Empty string when no image URL is available.
//   final String image;

//   /// Average user rating (0.0–5.0).
//   final double rating;

//   /// Total number of user reviews.
//   final int reviewCount;

//   /// Meal types this recipe belongs to (e.g., `["Breakfast"]`, `["Dinner", "Snack"]`).
//   final List<String> mealType;

//   const RecipeModel({
//     required this.id,
//     required this.name,
//     required this.ingredients,
//     required this.instructions,
//     required this.prepTimeMinutes,
//     required this.cookTimeMinutes,
//     required this.servings,
//     required this.difficulty,
//     required this.cuisine,
//     required this.caloriesPerServing,
//     required this.tags,
//     required this.userId,
//     required this.image,
//     required this.rating,
//     required this.reviewCount,
//     required this.mealType,
//   });

//   /// Parses a [RecipeModel] from a JSON map as returned by the DummyJSON API.
//   ///
//   /// Handles numeric type variance (int vs double) safely using `num` coercion.
//   /// The `images` array is collapsed to a single [image] URL; an absent or
//   /// empty array results in an empty string.
//   factory RecipeModel.fromJson(Map<String, dynamic> json) {
//     final String image = json['image'] as String? ?? '';

//     return RecipeModel(
//       id: (json['id'] as num).toInt(),
//       name: json['name'] as String? ?? '',
//       ingredients: _parseStringList(json['ingredients']),
//       instructions: _parseStringList(json['instructions']),
//       prepTimeMinutes: (json['prepTimeMinutes'] as num?)?.toInt() ?? 0,
//       cookTimeMinutes: (json['cookTimeMinutes'] as num?)?.toInt() ?? 0,
//       servings: (json['servings'] as num?)?.toInt() ?? 0,
//       difficulty: json['difficulty'] as String? ?? '',
//       cuisine: json['cuisine'] as String? ?? '',
//       caloriesPerServing: (json['caloriesPerServing'] as num?)?.toInt() ?? 0,
//       tags: _parseStringList(json['tags']),
//       userId: (json['userId'] as num?)?.toInt() ?? 0,
//       image: image,
//       rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
//       reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
//       mealType: _parseStringList(json['mealType']),
//     );
//   }

//   /// Safely converts a JSON list value to [List<String>].
//   ///
//   /// Returns an empty list when [raw] is null or not a [List].
//   static List<String> _parseStringList(dynamic raw) {
//     if (raw is List) {
//       return raw.map((e) => e.toString()).toList();
//     }
//     return const [];
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     return other is RecipeModel && other.id == id;
//   }

//   @override
//   int get hashCode => id.hashCode;

//   @override
//   String toString() => 'RecipeModel(id: $id, name: $name)';
// }
