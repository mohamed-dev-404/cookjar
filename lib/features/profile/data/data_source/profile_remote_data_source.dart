import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/core/errors/models/error_model.dart';
import 'package:cookjar/features/profile/data/models/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getUserProfile();
  Future<void> updateUserProfile(ProfileModel profile);
  Future<void> signOut();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  ProfileRemoteDataSourceImpl({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<ProfileModel> getUserProfile() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        // Fallback default user profile if unauthenticated
        return const ProfileModel(
          userId: 'guest_id',
          name: 'Yomna Abdelmegeed',
          email: 'yomna@example.com',
          favoriteMeal: 'Dinner 🍝',
        );
      }

      // Populate from current FirebaseAuth user data
      return ProfileModel(
        userId: user.uid,
        name: user.displayName?.isNotEmpty == true
            ? user.displayName!
            : 'Yomna Abdelmegeed',
        email: user.email ?? 'yomna@example.com',
        profileImage: user.photoURL ?? '',
        favoriteMeal: 'Dinner 🍝',
      );
    } catch (e) {
      throw ProfileException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to fetch user profile: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<void> updateUserProfile(ProfileModel profile) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null && profile.name.isNotEmpty) {
        await user.updateDisplayName(profile.name);
        if (profile.profileImage.isNotEmpty) {
          await user.updatePhotoURL(profile.profileImage);
        }
      }
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
