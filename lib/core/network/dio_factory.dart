import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_endpoints.dart';

const String applicationJson = "application/json";
const String contentType = "Content-Type";
const String accept = "Accept";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
    };
    dio.options = BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        headers: headers,
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60));

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }

    return dio;
  }
}
