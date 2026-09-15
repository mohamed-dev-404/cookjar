import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/core/errors/models/error_model.dart';
import 'package:cookjar/features/profile/data/models/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getUserProfile();
  Future<void> updateUserProfile(ProfileModel profile, {File? newImage});
  Future<void> signOut();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  ProfileRemoteDataSourceImpl({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<ProfileModel> getUserProfile() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw ProfileException(
          errorModel: const ErrorModel(
            errorMessage: 'User is not authenticated',
          ),
        );
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) {
        throw ProfileException(
          errorModel: const ErrorModel(errorMessage: 'User profile not found'),
        );
      }

      final data = doc.data()!;
      return ProfileModel.fromJson(data, fallbackId: user.uid);
    } catch (e) {
      if (e is ProfileException) rethrow;
      throw ProfileException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to fetch user profile: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<void> updateUserProfile(ProfileModel profile, {File? newImage}) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw ProfileException(
          errorModel: const ErrorModel(
            errorMessage: 'User is not authenticated',
          ),
        );
      }

      String updatedImageUrl = profile.profileImage;

      // Convert new image to Base64 if provided
      if (newImage != null) {
        final bytes = await newImage.readAsBytes();
        final compressedBytes = await compute(_compressImage, bytes);
        final base64String = base64Encode(compressedBytes);
        updatedImageUrl = 'data:image/jpeg;base64,$base64String';
      }

      // Update FirebaseAuth Display Name & Photo
      if (profile.name.isNotEmpty) {
        await user.updateDisplayName(profile.name);
      }
      if (updatedImageUrl.isNotEmpty && !updatedImageUrl.startsWith('data:')) {
        await user.updatePhotoURL(updatedImageUrl);
      }

      // Merge into Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'name': profile.name,
        'favoriteMeal': profile.favoriteMeal,
        'profileImageUrl': updatedImageUrl,
      }, SetOptions(merge: true));
    } catch (e) {
      throw ProfileException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to update profile: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw ProfileException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to sign out: ${e.toString()}',
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
}

class ProfileException extends AppException {
  ProfileException({required super.errorModel});
}
