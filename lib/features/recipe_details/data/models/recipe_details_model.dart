class RecipeDetailsModel {
  final int id;
  final String name;
  final String image;
  final double rating;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int servings;
  final int caloriesPerServing;
  final List<String> ingredients;
  final List<String> instructions;

  const RecipeDetailsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.caloriesPerServing,
    required this.ingredients,
    required this.instructions,
  });

  /// Getter لحساب الوقت الإجمالي المعروض في التصميم (35 min)
  int get totalTimeMinutes => prepTimeMinutes + cookTimeMinutes;

  factory RecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailsModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      rating: (json['rating'] as num).toDouble(),
      prepTimeMinutes: json['prepTimeMinutes'] as int,
      cookTimeMinutes: json['cookTimeMinutes'] as int,
      servings: json['servings'] as int,
      caloriesPerServing: json['caloriesPerServing'] as int,
      ingredients: List<String>.from(json['ingredients'] as List),
      instructions: List<String>.from(json['instructions'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'prepTimeMinutes': prepTimeMinutes,
      'cookTimeMinutes': cookTimeMinutes,
      'servings': servings,
      'caloriesPerServing': caloriesPerServing,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }
}
