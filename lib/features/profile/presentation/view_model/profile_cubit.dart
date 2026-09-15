import 'dart:io';
import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/features/profile/data/repos/profile_repo.dart';
import 'package:cookjar/features/profile/presentation/view_model/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(const ProfileInitial());

  Future<void> fetchProfile() async {
    emit(const ProfileLoading());

    try {
      final profile = await profileRepo.getProfile();
      emit(ProfileSuccess(profile: profile));
    } on AppException catch (e) {
      emit(ProfileError(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await profileRepo.signOut();
      emit(const ProfileLoggedOut());
    } on AppException catch (e) {
      emit(ProfileError(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String favoriteMeal,
    File? newImage,
  }) async {
    if (state is! ProfileSuccess) return;

    final currentProfile = (state as ProfileSuccess).profile;

    emit(const ProfileUpdating());

    try {
      final updatedProfile = currentProfile.copyWith(
        name: name,
        favoriteMeal: favoriteMeal,
      );

      await profileRepo.updateProfile(updatedProfile, newImage: newImage);

      emit(const ProfileUpdateSuccess());
      // Re-fetch to display the fresh data
      await fetchProfile();
    } on AppException catch (e) {
      emit(ProfileUpdateError(errorMessage: e.errorModel.errorMessage));
      emit(
        ProfileSuccess(profile: currentProfile),
      ); // Revert back to view state
    } catch (e) {
      emit(ProfileUpdateError(errorMessage: e.toString()));
      emit(ProfileSuccess(profile: currentProfile));
    }
  }
}
