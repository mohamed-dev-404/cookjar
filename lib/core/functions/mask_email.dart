import 'package:cookjar/core/validators/app_validators.dart';

String maskEmail(String email) {
  if (AppValidators.validateEmail(email) != null) return email;

  final parts = email.split('@');
  final String username = parts[0];
  final String domain = parts[1];

  // If username is too short (e.g., 'ad@gmail.com'), just return as is or minimal mask
  if (username.length <= 3) {
    return '${username[0]}**@$domain';
  }

  // Get first two: 'ad'
  final String firstTwo = username.substring(0, 2);
  // Get last one: 'm'
  final String lastOne = username.substring(username.length - 1);

  // Combine: 'ad' + '******' + 'm' + '@' + 'sams.com'
  return '$firstTwo******$lastOne@$domain';
}
