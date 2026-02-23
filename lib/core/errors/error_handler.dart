import 'package:dio/dio.dart';

import 'exception.dart';
import 'failure.dart';

class ErrorHandler {
  //TODO: Handle all exceptionn with this method
  //! Thsi is a unused
  //! Error handling system.
  static Failure handleException(AppException exception) {
    if (exception is ServerException) {
      return ServerFailure(
        message: exception.message,
      );
    } else if (exception is CacheException) {
      return CacheFailure(
        message: exception.message,
      );
    } else if (exception is ModelConversionException) {
      return ModelConversionFailure(
        message: exception.message,
      );
    } else if (exception is DioException) {
      return DioFailure(
        message: exception.message,
      );
    } else {
      return UnknownFailure(
        message: exception.message,
      );
    }
  }

  static String handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.cancel:
        return 'Request cancelled.';
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout.';
      case DioExceptionType.badCertificate:
        return 'Bad certificate.';
      case DioExceptionType.badResponse:
        return 'Bad response.';
      case DioExceptionType.connectionError:
        return 'Connection error.';
      case DioExceptionType.unknown:
        return 'Unknown error.';
    }
  }
}
