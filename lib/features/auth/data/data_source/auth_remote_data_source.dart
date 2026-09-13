import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/core/errors/models/error_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<void> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<void> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw _handleGenericException(e);
    }
  }

  @override
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw _handleGenericException(e);
    }
  }

  /// Map Firebase Auth Exception codes to user-friendly messages
  AppException _handleFirebaseAuthException(FirebaseAuthException e) {
    String message;

    switch (e.code) {
      case 'email-already-in-use':
        message = 'This email address is already registered.';
        break;
      case 'weak-password':
        message = 'The password is too weak. Please use a stronger password.';
        break;
      case 'invalid-email':
        message = 'The email address is invalid.';
        break;
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        message = 'Incorrect email or password.';
        break;
      case 'user-disabled':
        message = 'This user account has been disabled.';
        break;
      case 'too-many-requests':
        message = 'Too many failed login attempts. Please try again later.';
        break;
      case 'network-request-failed':
        message =
            'Network connection failed. Please check your internet connection.';
        break;
      case 'operation-not-allowed':
        message = 'Email and password authentication is not enabled.';
        break;
      default:
        message = e.message ?? 'An unexpected authentication error occurred.';
        break;
    }

    return _AuthException(errorModel: ErrorModel(errorMessage: message));
  }

  AppException _handleGenericException(dynamic error) {
    return _AuthException(
      errorModel: ErrorModel(
        errorMessage: error.toString().replaceFirst('Exception: ', ''),
      ),
    );
  }
}

class _AuthException extends AppException {
  _AuthException({required super.errorModel});
}
