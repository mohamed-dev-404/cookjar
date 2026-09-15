import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/core/errors/models/error_model.dart';
import 'package:cookjar/features/profile/data/models/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getUserProfile();
  Future<void> updateUserProfile(ProfileModel profile, {File? newImage});
  Future<void> signOut();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ProfileRemoteDataSourceImpl({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance;

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

      // Upload new image if provided
      if (newImage != null) {
        final ref = _storage.ref().child(
          'users/${user.uid}/profile/profile_image',
        );
        final uploadTask = await ref.putFile(newImage);
        updatedImageUrl = await uploadTask.ref.getDownloadURL();
      }

      // Update FirebaseAuth Display Name & Photo
      if (profile.name.isNotEmpty) {
        await user.updateDisplayName(profile.name);
      }
      if (updatedImageUrl.isNotEmpty) {
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
}

class ProfileException extends AppException {
  ProfileException({required super.errorModel});
}
