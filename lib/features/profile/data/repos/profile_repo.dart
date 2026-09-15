import 'dart:io';
import 'package:cookjar/features/profile/data/models/profile_model.dart';

abstract class ProfileRepo {
  Future<ProfileModel> getProfile();
  Future<void> updateProfile(ProfileModel profile, {File? newImage});
  Future<void> signOut();
}
