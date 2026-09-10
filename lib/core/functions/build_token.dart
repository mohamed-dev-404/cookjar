import 'package:cookjar/core/constants/api_keys.dart';

String buildToken(String? token) {
  return '${ApiValues.bearer} $token';
}
