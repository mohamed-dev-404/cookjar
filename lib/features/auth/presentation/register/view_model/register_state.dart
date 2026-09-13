import 'package:flutter/foundation.dart';

@immutable
sealed class RegisterState {
  const RegisterState();
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

final class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess();
}

final class RegisterError extends RegisterState {
  final String errorMessage;

  const RegisterError({required this.errorMessage});
}
