import 'package:dio/dio.dart';

import '../../app/app.dart';

class APIException implements Exception {
  final dynamic error;
  APIException({required this.error});
}

class ExceptionHandler {
  ExceptionHandler._privateConstructor();

  static dynamic handleError(Exception err) {
    if (err is DioException) {
      switch (err.type) {
        case DioExceptionType.badResponse:
          return err.response?.data;
        case DioExceptionType.sendTimeout:
          return APIException(error: AppTrKeys.noInternet);
        case DioExceptionType.connectionTimeout:
          return APIException(error: AppTrKeys.noInternet);
        case DioExceptionType.receiveTimeout:
          return APIException(error: AppTrKeys.requestTimeout);
        case DioExceptionType.connectionError:
          return APIException(error: AppTrKeys.connectionTimeout);
        case DioExceptionType.badCertificate:
          return APIException(error: AppTrKeys.somethingWentWrong);
        case DioExceptionType.cancel:
          return APIException(error: AppTrKeys.somethingWentWrong);
        case DioExceptionType.unknown:
          return APIException(error: AppTrKeys.somethingWentWrong);
      }
    } else {
      return APIException(error: AppTrKeys.somethingWentWrong);
    }
  }
}
