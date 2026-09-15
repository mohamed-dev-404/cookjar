import 'dart:io';

import 'package:cookjar/features/complete_profile/data/data_source/complete_profile_remote_data_source.dart';
import 'package:cookjar/features/complete_profile/data/repos/complete_profile_repo.dart';

class CompleteProfileRepoImpl implements CompleteProfileRepo {
  final CompleteProfileRemoteDataSource remoteDataSource;

  const CompleteProfileRepoImpl({required this.remoteDataSource});

  @override
  Future<void> completeProfile({
    required String uid,
    required String name,
    required String email,
    required String favoriteMeal,
    File? imageFile,
  }) async {
    String profileImageUrl = '';

    // If an image was selected, upload it first
    if (imageFile != null) {
      profileImageUrl = await remoteDataSource.uploadProfileImage(
        uid: uid,
        imageFile: imageFile,
      );
    }

    // Save profile data to Firestore
    await remoteDataSource.saveProfile(
      uid: uid,
      name: name,
      email: email,
      favoriteMeal: favoriteMeal,
      profileImageUrl: profileImageUrl,
    );
  }
}
