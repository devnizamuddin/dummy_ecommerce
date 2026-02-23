import 'package:dio/dio.dart';

import 'exception.dart';
import 'failure.dart';

class ErrorHandler {
  const ErrorHandler._();

  /// Maps a known [AppException] to the corresponding [Failure].
  static Failure handleException(AppException exception) {
    if (exception is ServerException) {
      return ServerFailure(message: exception.message);
    } else if (exception is CacheException) {
      return CacheFailure(message: exception.message);
    } else if (exception is ModelConversionException) {
      return ModelConversionFailure(message: exception.message);
    } else if (exception is NetworkException) {
      return NetworkFailure(message: exception.message);
    } else {
      return UnknownFailure(message: exception.message);
    }
  }

  /// Converts a [DioException] into a human-readable error message.
  static String handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Please check your internet.';
      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond.';
      case DioExceptionType.sendTimeout:
        return 'Request timed out while sending data.';
      case DioExceptionType.badCertificate:
        return 'Insecure connection detected.';
      case DioExceptionType.badResponse:
        final code = exception.response?.statusCode;
        return 'Server returned an error (status $code).';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      case DioExceptionType.unknown:
        return 'An unexpected error occurred.';
    }
  }
}
