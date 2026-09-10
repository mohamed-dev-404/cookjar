import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cookjar/core/services/cache/secure_storage/secure_cache_keys.dart';
import 'package:cookjar/core/logging/app_logger.dart';

///! ===================================================
///! SecureStorageService
///! ===================================================
///* This service is used to **store sensitive data securely**
/// (tokens, user credentials, etc.)
///
///  It follows the Singleton pattern → only one instance is created.
///  Uses `flutter_secure_storage` which is encrypted.
///  Must call `init()` once before using it.
///
/// Example setup in [main]:
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///?   await SecureStorageService.instance.init(); // init once
///   runApp(MyApp());
/// }
/// ```
///
/// Example usage:
/// ```dart
/// await SecureStorageService.instance.setString('token', 'abcd1234');
/// final token = await SecureStorageService.instance.getString('token');
/// print(token); // abcd1234
/// ```
class SecureStorageService {
  static final SecureStorageService instance = SecureStorageService._internal();

  SecureStorageService._internal(); // Private constructor for singleton pattern

  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  bool _isInitialized = false;

  ///! Must be called once at app startup
  Future<void> init() async {
    if (_isInitialized) return;

    await _storage.containsKey(key: '_health_check_');
    _isInitialized = true;

    AppLogger.success(
      'SecureStorageService initialized successfully',
      tag: 'SecureStorage',
    );
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError(
        'SecureStorageService.init() must be called before usage',
      );
    }
  }

  //! ===============================
  //! Generic Methods
  //! ===============================

  //* Set a string value by key
  Future<void> setString(String key, String value) async {
    _ensureInitialized();
    await _storage.write(key: key, value: value);
  }

  //* Get a string value by key
  Future<String?> getString(String key) async {
    _ensureInitialized();
    return _storage.read(key: key);
  }

  //* Remove a value by key
  Future<void> remove(String key) async {
    _ensureInitialized();
    await _storage.delete(key: key);
  }

  //* Clear all stored data
  Future<void> clearAll() async {
    _ensureInitialized();
    await _storage.deleteAll();
  }

  //! ===============================
  //! App-specific helpers
  //! ===============================

  //* Save access token
  Future<void> saveAccessToken(String? token) async {
    if (token != null) {
      await setString(SecureStorageKeys.accessToken, token);
    } else {
      AppLogger.error('Token is null', tag: 'SecureStorage');
    }
  }

  //* Get access token
  Future<String?> getAccessToken() async {
    return getString(SecureStorageKeys.accessToken);
  }

  //* Delete access token
  Future<void> deleteAccessToken() async {
    await remove(SecureStorageKeys.accessToken);
  }

  //* Save refresh token
  Future<void> saveRefreshToken(String? token) async {
    if (token != null) {
      await setString(SecureStorageKeys.refreshToken, token);
    } else {
      AppLogger.error('Token is null', tag: 'SecureStorage');
    }
  }

  //* Get refresh token
  Future<String?> getRefreshToken() async {
    return getString(SecureStorageKeys.refreshToken);
  }

  //* Delete refresh token
  Future<void> deleteRefreshToken() async {
    await remove(SecureStorageKeys.refreshToken);
  }

  //* Save user role
  Future<void> saveUserRole(String? role) async {
    if (role != null) {
      await setString(SecureStorageKeys.role, role);
    } else {
      AppLogger.error('role is null', tag: 'SecureStorage');
    }
  }

  //* Get user role
  Future<String?> getUserRole() async {
    return getString(SecureStorageKeys.role);
  }
}
