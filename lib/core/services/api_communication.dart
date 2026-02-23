import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constant/app_constant.dart';
import '../errors/error_handler.dart';
import '../errors/exception.dart';
import '../models/api_response.dart';

class ApiCommunication {
  late final Dio _dio;

  ApiCommunication({
    Duration connectTimeout = const Duration(seconds: 60),
    Duration receiveTimeout = const Duration(seconds: 60),
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: kBaseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        responseType: ResponseType.json,
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
    }
  }
  //* ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  //* ┃                             GET Request                                ┃
  //* ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  Future<ApiResponse> doGetRequest({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return ApiResponse(
        statusCode: response.statusCode ?? kUnknownErrorCode,
        data: response.data,
        isSuccess: response.statusCode == 200,
      );
    } on DioException catch (e) {
      throw ServerException(message: ErrorHandler.handleDioException(e));
    }
  }

  //* ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  //* ┃ Optional                                  ┃
  //* ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  void dispose() {
    _dio.close(force: true);
  }
}
