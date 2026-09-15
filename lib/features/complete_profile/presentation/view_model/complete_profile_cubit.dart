import 'dart:io';

import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/features/complete_profile/data/repos/complete_profile_repo.dart';
import 'package:cookjar/features/complete_profile/presentation/view_model/complete_profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  final CompleteProfileRepo repo;

  CompleteProfileCubit({required this.repo})
    : super(const CompleteProfileInitial());

  Future<void> completeProfile({
    required String name,
    required String email,
    required String favoriteMeal,
    required File imageFile,
  }) async {
    emit(const CompleteProfileLoading());

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(
          const CompleteProfileError(
            errorMessage: 'User is not authenticated.',
          ),
        );
        return;
      }

      await repo.completeProfile(
        uid: user.uid,
        name: name,
        email: email,
        favoriteMeal: favoriteMeal,
        imageFile: imageFile,
      );

      // Also update the user's display name in FirebaseAuth
      await user.updateDisplayName(name);

      if (isClosed) return;
      emit(const CompleteProfileSuccess());
    } on AppException catch (e) {
      if (isClosed) return;
      emit(CompleteProfileError(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      if (isClosed) return;
      emit(CompleteProfileError(errorMessage: e.toString()));
    }
  }
}
