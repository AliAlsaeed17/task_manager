import 'package:dio/dio.dart';
import 'package:task_manager/core/utils/app_strings.dart';

import 'failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectTimeOut,
  cancel,
  receiveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  unProcessableEntity,
  unknown
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(
            code: ResponseCode.success, message: ResponseMessage.successApi);
      case DataSource.noContent:
        return Failure(
            code: ResponseCode.noContent, message: ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(
            code: ResponseCode.badRequest, message: ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(
            code: ResponseCode.forbidden, message: ResponseMessage.forbidden);
      case DataSource.unAuthorised:
        return Failure(
            code: ResponseCode.unauthorized,
            message: ResponseMessage.unauthorized);
      case DataSource.notFound:
        return Failure(
            code: ResponseCode.notFound, message: ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(
            code: ResponseCode.internalServerError,
            message: ResponseMessage.internalServerError);
      case DataSource.connectTimeOut:
        return Failure(
            code: ResponseCode.connectTimeOut,
            message: ResponseMessage.connectTimeOut);
      case DataSource.cancel:
        return Failure(
            code: ResponseCode.cancel, message: ResponseMessage.cancelApi);
      case DataSource.receiveTimeOut:
        return Failure(
            code: ResponseCode.receiveTimeout,
            message: ResponseMessage.receiveTimeout);
      case DataSource.sendTimeOut:
        return Failure(
            code: ResponseCode.sendTimeOut,
            message: ResponseMessage.sendTimeOut);
      case DataSource.cacheError:
        return Failure(
            code: ResponseCode.cacheError, message: ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(
            code: ResponseCode.noInternetConnecting,
            message: ResponseMessage.noInternetConnecting);
      case DataSource.unknown:
        return Failure(
            code: ResponseCode.unknown, message: ResponseMessage.unknown);
      case DataSource.unProcessableEntity:
        return Failure(
            code: ResponseCode.unProcessableEntity,
            message: ResponseMessage.unProcessableEntity);
    }
  }
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeOut.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeOut.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeOut.getFailure();
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.unknown:
      return DataSource.unknown.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.unknown.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    case DioExceptionType.badResponse:
      if (error.response?.data != null) {
        if (error.response?.data['message'] != null) {
          return Failure(
              code: ResponseCode.badRequest,
              message: error.response?.data['message']);
        } else {
          return DataSource.badRequest.getFailure();
        }
      } else {
        return DataSource.badRequest.getFailure();
      }
  }
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int unProcessableEntity = 422;
  static const int internalServerError = 500;

  // local status code
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeOut = -4;
  static const int cacheError = -5;
  static const int noInternetConnecting = -6;
  static const int unknown = -7;
}

class ResponseMessage {
  static const String successApi = AppStrings.successApi;
  static const String noContent = AppStrings.noContent;
  static const String badRequest = AppStrings.badRequest;
  static const String forbidden = AppStrings.forbidden;
  static const String unauthorized = AppStrings.unauthorized;
  static const String notFound = AppStrings.notFound;
  static const String unProcessableEntity = AppStrings.unProcessableEntity;
  static const String internalServerError = AppStrings.internalServerError;

  // local status code
  static const String connectTimeOut = AppStrings.connectTimeOut;
  static const String cancelApi = AppStrings.cancelApi;
  static const String receiveTimeout = AppStrings.receiveTimeout;
  static const String sendTimeOut = AppStrings.sendTimeOut;
  static const String cacheError = AppStrings.cacheError;
  static const String noInternetConnecting = AppStrings.noInternetConnecting;
  static const String unknown = AppStrings.unknown;
}

class ApiInternalStatus {
  static const bool success = true;
}
