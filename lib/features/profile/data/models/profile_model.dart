import 'package:flutter/foundation.dart';

@immutable
class ProfileModel {
  final String userId;
  final String name;
  final String email;
  final String profileImage;
  final String favoriteMeal;
  final int savedRecipesCount;

  const ProfileModel({
    required this.userId,
    required this.name,
    required this.email,
    this.profileImage = '',
    this.favoriteMeal = 'Dinner 🍝',
    this.savedRecipesCount = 0,
  });

  factory ProfileModel.fromJson(
    Map<String, dynamic> json, {
    required String fallbackId,
  }) {
    return ProfileModel(
      userId: json['userId'] as String? ?? fallbackId,
      name:
          json['name'] as String? ??
          json['displayName'] as String? ??
          'CookJar User',
      email: json['email'] as String? ?? '',
      profileImage:
          json['profileImageUrl'] as String? ??
          json['photoURL'] as String? ??
          '',
      favoriteMeal: json['favoriteMeal'] as String? ?? 'Dinner 🍝',
      savedRecipesCount: (json['savedRecipesCount'] as num?)?.toInt() ?? 0,
    );
  }

  /// Convert ProfileModel instance to JSON map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'profileImageUrl': profileImage,
      'favoriteMeal': favoriteMeal,
      'savedRecipesCount': savedRecipesCount,
    };
  }

  /// Create a copy with updated properties
  ProfileModel copyWith({
    String? userId,
    String? name,
    String? email,
    String? profileImage,
    String? favoriteMeal,
    int? savedRecipesCount,
  }) {
    return ProfileModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      favoriteMeal: favoriteMeal ?? this.favoriteMeal,
      savedRecipesCount: savedRecipesCount ?? this.savedRecipesCount,
    );
  }
}
