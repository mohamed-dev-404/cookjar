import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();

  //? Base URL
  static final String baseUrl = dotenv.env[EnvKeys.baseUrl]!;

  //? ApI Key
  static final String apikey = dotenv.env[EnvKeys.apikey]!;
}

/// Environment variable keys
class EnvKeys {
  EnvKeys._();

  static const String baseUrl = 'BASE_URL';
  static const String apikey = 'API_KEY';
}
