import 'dart:io';

abstract class CompleteProfileRepo {
  Future<void> completeProfile({
    required String uid,
    required String name,
    required String email,
    required String favoriteMeal,
    File? imageFile,
  });
}
