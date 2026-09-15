import 'package:cookjar/features/home/data/models/home_user_model.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeSuccess extends HomeState {
  final HomeUserModel user;

  const HomeSuccess({required this.user});
}

final class HomeError extends HomeState {
  final String errorMessage;

  const HomeError({required this.errorMessage});
}
