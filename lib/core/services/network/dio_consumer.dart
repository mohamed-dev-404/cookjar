import 'package:cookjar/core/constants/app_constants.dart';
import 'package:cookjar/core/errors/exceptions/api_exception.dart';
import 'package:cookjar/core/errors/handlers/dio_exception_handler.dart';
import 'package:cookjar/core/errors/models/error_model.dart';
import 'package:cookjar/core/services/network/api_consumer.dart';
import 'package:cookjar/core/services/network/interceptors/header_interceptor.dart';
import 'package:cookjar/core/services/network/interceptors/logger_interceptor.dart';
import 'package:cookjar/core/services/network/interceptors/network_interceptor.dart';
import 'package:cookjar/core/services/network/interceptors/retry_interceptor.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio) {
    dio.options.baseUrl = AppConstants.baseUrl;
    dio.options
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 15)
      ..sendTimeout = const Duration(seconds: 15);
    dio.interceptors.add(HeaderInterceptor());
    dio.interceptors.add(NetworkInterceptor(Connectivity()));
    dio.interceptors.add(RetryInterceptor(dio, maxRetries: 3));
    if (!kReleaseMode) {
      dio.interceptors.add(DioLogger());
    }
  }

  //! GET Request
  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  //! PATCH Request
  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  //! POST Request
  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  //! PUT Request
  @override
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  //! DELETE Request
  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (e) {
      _handleException(e);
    }
  }

  ///* helper method to handle exceptions and throw suitable ApiException
  Never _handleException(Object e) {
    if (e is DioException) {
      handleDioExceptions(
        e,
      ); // throw suitable ApiException based on DioException type
    }
    throw ApiException(errorModel: ErrorModel(errorMessage: e.toString()));
  }
}
