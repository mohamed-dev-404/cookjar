import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/core/errors/models/error_model.dart';
import 'package:cookjar/features/home/data/models/home_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class HomeRemoteDataSource {
  Future<HomeUserModel> getCurrentUser();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  HomeRemoteDataSourceImpl({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<HomeUserModel> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw HomeException(
          errorModel: const ErrorModel(errorMessage: 'User is not authenticated'),
        );
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) {
        // Fallback to Auth data if Firestore doc doesn't exist yet
        return HomeUserModel(
          name: user.displayName ?? 'Chef',
          profileImageUrl: user.photoURL ?? '',
        );
      }

      final data = doc.data()!;
      return HomeUserModel(
        name: data['name'] as String? ?? 'Chef',
        profileImageUrl: data['profileImageUrl'] as String? ?? '',
      );
    } catch (e) {
      if (e is HomeException) rethrow;
      throw HomeException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to fetch user data: ${e.toString()}',
        ),
      );
    }
  }
}

class HomeException extends AppException {
  HomeException({required super.errorModel});
}
