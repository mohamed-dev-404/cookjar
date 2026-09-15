import 'dart:io';

import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/core/errors/models/error_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

abstract class CompleteProfileRemoteDataSource {
  /// Uploads a profile image to Firebase Storage and returns the download URL.
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
  final FirebaseStorage _storage;

  CompleteProfileRemoteDataSourceImpl({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance;

  @override
  Future<String> uploadProfileImage({
    required String uid,
    required File imageFile,
  }) async {
    try {
      final ref = _storage.ref().child('users/$uid/profile/profile_image');
      final uploadTask = await ref.putFile(imageFile);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw CompleteProfileException(
        errorModel: ErrorModel(
          errorMessage: e.message ?? 'Failed to upload profile image.',
        ),
      );
    } catch (e) {
      throw CompleteProfileException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to upload image: ${e.toString()}',
        ),
      );
    }
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
