import 'dart:io';

import 'package:dio/dio.dart';

abstract class DioExceptions {
  static String errorString(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        return "Request to API server was cancelled";
      case DioErrorType.connectionTimeout:
        return "Connection timeout with API server";
      case DioErrorType.unknown:
        if (dioError.error is SocketException) {
          return "Please check your internet";
        }
        return "Something went wrong";
      case DioErrorType.receiveTimeout:
        return "Receive timeout in connection with API server";
      case DioErrorType.badResponse:
        return _handleError(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioErrorType.sendTimeout:
        return "Send timeout in connection with API server";
      default:
        return "Something went wrong";
    }
  }

  static String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return error?["message"] ?? "ERROR Http status error [404]";
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }
}
