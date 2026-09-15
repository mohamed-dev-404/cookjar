sealed class CompleteProfileState {
  const CompleteProfileState();
}

class CompleteProfileInitial extends CompleteProfileState {
  const CompleteProfileInitial();
}

class CompleteProfileLoading extends CompleteProfileState {
  const CompleteProfileLoading();
}

class CompleteProfileSuccess extends CompleteProfileState {
  const CompleteProfileSuccess();
}

class CompleteProfileError extends CompleteProfileState {
  final String errorMessage;

  const CompleteProfileError({required this.errorMessage});
}
