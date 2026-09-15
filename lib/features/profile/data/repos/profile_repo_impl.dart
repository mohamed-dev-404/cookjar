import 'dart:io';
import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/features/profile/data/data_source/profile_local_data_source.dart';
import 'package:cookjar/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:cookjar/features/profile/data/models/profile_model.dart';
import 'package:cookjar/features/profile/data/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  ProfileRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final remoteProfile = await remoteDataSource.getUserProfile();
      final savedCount = await localDataSource.getSavedRecipesCount();

      return remoteProfile.copyWith(savedRecipesCount: savedCount);
    } on AppException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to load profile details: ${e.toString()}');
    }
  }

  @override
  Future<void> updateProfile(ProfileModel profile, {File? newImage}) async {
    try {
      await remoteDataSource.updateUserProfile(profile, newImage: newImage);
    } on AppException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to update profile: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await remoteDataSource.signOut();
    } on AppException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }
}
