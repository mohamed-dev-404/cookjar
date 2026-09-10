import 'package:cookjar/core/constants/api_keys.dart';

class ErrorModel {
  final String errorMessage;
  final int? statusCode;

  const ErrorModel({required this.errorMessage, this.statusCode});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      errorMessage: json[ApiKeys.message]?.toString().trim().isNotEmpty == true
          ? json[ApiKeys.message].toString().trim()
          : 'Unexpected error occurred',
    );
  }
}
