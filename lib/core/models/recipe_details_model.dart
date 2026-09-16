import 'package:hive_flutter/hive_flutter.dart';

class RecipeModel {
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

  const RecipeModel({
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

  int get totalTimeMinutes => prepTimeMinutes + cookTimeMinutes;

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
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

// ---------------------------------------------------------------------------
// Hand-written Hive TypeAdapter — avoids build_runner dependency conflicts.
//
// typeId: 0  — first and only adapter in this project.
// Field indices are stable; do NOT change them once data is persisted.
//   0  → id
//   1  → name
//   2  → image
//   3  → rating
//   4  → prepTimeMinutes
//   5  → cookTimeMinutes
//   6  → servings
//   7  → caloriesPerServing
//   8  → ingredients
//   9  → instructions
// ---------------------------------------------------------------------------

class RecipeModelAdapter extends TypeAdapter<RecipeModel> {
  @override
  final int typeId = 0;

  @override
  RecipeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeModel(
      id: fields[0] as int,
      name: fields[1] as String,
      image: fields[2] as String,
      rating: fields[3] as double,
      prepTimeMinutes: fields[4] as int,
      cookTimeMinutes: fields[5] as int,
      servings: fields[6] as int,
      caloriesPerServing: fields[7] as int,
      ingredients: (fields[8] as List).cast<String>(),
      instructions: (fields[9] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecipeModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.prepTimeMinutes)
      ..writeByte(5)
      ..write(obj.cookTimeMinutes)
      ..writeByte(6)
      ..write(obj.servings)
      ..writeByte(7)
      ..write(obj.caloriesPerServing)
      ..writeByte(8)
      ..write(obj.ingredients)
      ..writeByte(9)
      ..write(obj.instructions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
