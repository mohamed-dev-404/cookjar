import 'package:cookjar/features/profile/data/models/profile_model.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ProfileState {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class ProfileSuccess extends ProfileState {
  final ProfileModel profile;

  const ProfileSuccess({required this.profile});
}

final class ProfileError extends ProfileState {
  final String errorMessage;

  const ProfileError({required this.errorMessage});
}

final class ProfileLoggedOut extends ProfileState {
  const ProfileLoggedOut();
}
