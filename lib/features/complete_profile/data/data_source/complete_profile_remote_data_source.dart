import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/core/errors/models/error_model.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

abstract class CompleteProfileRemoteDataSource {
  /// Converts a profile image to Base64 and returns it as a data URI string.
  Future<String> uploadProfileImage({
    required String uid,
    required File imageFile,
  });

  /// Saves the user profile document to Firestore under `users/{uid}`.
  Future<void> saveProfile({
    required String uid,
    required String name,
    required String email,
    required String favoriteMeal,
    required String profileImageUrl,
  });
}

class CompleteProfileRemoteDataSourceImpl
    implements CompleteProfileRemoteDataSource {
  final FirebaseFirestore _firestore;

  CompleteProfileRemoteDataSourceImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<String> uploadProfileImage({
    required String uid,
    required File imageFile,
  }) async {
    try {
      // Read the image file bytes
      final bytes = await imageFile.readAsBytes();

      // Compress the image in an isolate to avoid blocking the UI
      final compressedBytes = await compute(_compressImage, bytes);

      // Convert to Base64 data URI
      final base64String = base64Encode(compressedBytes);
      final dataUri = 'data:image/jpeg;base64,$base64String';

      return dataUri;
    } catch (e) {
      throw CompleteProfileException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to process image: ${e.toString()}',
        ),
      );
    }
  }

  /// Compresses an image to a reasonable size for Firestore storage.
  /// Runs in a separate isolate via [compute].
  static Uint8List _compressImage(Uint8List bytes) {
    final image = img.decodeImage(bytes);
    if (image == null) {
      throw Exception('Could not decode image');
    }

    // Resize if too large (max 300px for profile images)
    img.Image resized;
    if (image.width > 300 || image.height > 300) {
      resized = img.copyResize(
        image,
        width: 300,
        height: 300,
        maintainAspect: true,
      );
    } else {
      resized = image;
    }

    // Encode as JPEG with 70% quality
    final compressed = img.encodeJpg(resized, quality: 70);
    return Uint8List.fromList(compressed);
  }

  @override
  Future<void> saveProfile({
    required String uid,
    required String name,
    required String email,
    required String favoriteMeal,
    required String profileImageUrl,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'favoriteMeal': favoriteMeal,
        'profileImageUrl': profileImageUrl,
        'profileCompleted': true,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw CompleteProfileException(
        errorModel: ErrorModel(
          errorMessage: e.message ?? 'Failed to save profile data.',
        ),
      );
    } catch (e) {
      throw CompleteProfileException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to save profile: ${e.toString()}',
        ),
      );
    }
  }
}

class CompleteProfileException extends AppException {
  CompleteProfileException({required super.errorModel});
}
