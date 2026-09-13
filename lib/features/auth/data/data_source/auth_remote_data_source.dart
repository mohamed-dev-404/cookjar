import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/core/errors/models/error_model.dart';

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
  const AuthRemoteDataSourceImpl();

  @override
  Future<void> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Firebase Authentication flow
      // In production / with firebase_auth package, this calls:
      // await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      // await FirebaseAuth.instance.currentUser?.updateDisplayName(name);

      // Simulate async Firebase auth registration call for network verification
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Firebase Login flow
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Map Firebase and Auth Exceptions cleanly to AppErrorModel
  AppException _handleAuthException(dynamic error) {
    String message = 'Authentication failed. Please try again.';

    final String errorStr = error.toString().toLowerCase();
    if (errorStr.contains('email-already-in-use')) {
      message = 'This email address is already in use by another account.';
    } else if (errorStr.contains('weak-password')) {
      message = 'The password provided is too weak.';
    } else if (errorStr.contains('invalid-email')) {
      message = 'The email address is not valid.';
    } else if (errorStr.contains('network-request-failed') ||
        errorStr.contains('network')) {
      message =
          'Network connection failed. Please check your internet connection.';
    } else if (errorStr.contains('user-not-found') ||
        errorStr.contains('wrong-password')) {
      message = 'Invalid email or password.';
    }

    return _AuthException(errorModel: ErrorModel(errorMessage: message));
  }
}

class _AuthException extends AppException {
  _AuthException({required super.errorModel});
}
