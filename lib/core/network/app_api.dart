import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;

abstract class AppServiceClient {
  AppServiceClient(Dio dio);

  Future<T> performPostRequest<T>(String endpoint, Map<String, dynamic> data,
      T Function(Map<String, dynamic>) fromJson,
      {String token = ''});

  Future<T> performDeleteRequest<T>(String endpoint,
      {String token = '', T Function(Map<String, dynamic>)? fromJson});

  Future<T> performPostRequestWithFormData<T>(String endpoint, d.FormData data,
      T Function(Map<String, dynamic>) fromJson,
      {String token = ''});

  Future<T> performGetRequest<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson,
      {String token = '', Map<String, dynamic>? params});

  Future<T> performPutRequest<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson,
      {String token = '', Map<String, dynamic>? params});
}

class AppServiceClientImpl extends AppServiceClient {
  final Dio dio;

  AppServiceClientImpl(this.dio) : super(dio);

  @override
  Future<T> performGetRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    String token = '',
    Map<String, dynamic>? params,
    bool hasDataBody = true,
  }) async {
    final response = await dio.get(
      endpoint,
      queryParameters: params,
      options: GetOptions.getOptionsWithToken(token),
    );
    final value = fromJson(response.data! as Map<String, dynamic>);
    return value;
  }

  @override
  Future<T> performPostRequest<T>(
    String endpoint,
    Map<String, dynamic>? data,
    T Function(Map<String, dynamic>) fromJson, {
    bool isEmptyRequest = false,
    bool hasDataBody = true,
    String token = '',
  }) async {
    final response = await dio.post(
      endpoint,
      data: data,
      options: GetOptions.getOptionsWithToken(token),
    );

    final value = fromJson(response.data! as Map<String, dynamic>);

    return value;
  }

  @override
  Future<T> performDeleteRequest<T>(String endpoint,
      {String token = '', T Function(Map<String, dynamic>)? fromJson}) async {
    final response = await dio.delete(
      endpoint,
      options: GetOptions.getOptionsWithToken(token),
    );
    final value = fromJson!(response.data! as Map<String, dynamic>);

    return value;
  }

  @override
  Future<T> performPostRequestWithFormData<T>(String endpoint, FormData data,
      T Function(Map<String, dynamic> p1) fromJson,
      {String token = ''}) async {
    final response = await dio.post(
      endpoint,
      data: data,
      options: GetOptions.getOptionsWithToken(token),
    );

    final value = fromJson(response.data! as Map<String, dynamic>);

    return value;
  }

  @override
  Future<T> performPutRequest<T>(
      String endpoint, T Function(Map<String, dynamic> p1) fromJson,
      {String token = '',
      Map<String, dynamic>? params,
      Map<String, dynamic>? queryParameters}) async {
    final response = await dio.put(
      endpoint,
      data: params,
      queryParameters: queryParameters,
      options: GetOptions.getOptionsWithToken(token),
    );
    final value = fromJson(response.data! as Map<String, dynamic>);
    return value;
  }
}

class GetOptions {
  static Options options = Options();

  static Options getOptionsWithToken(String token) {
    if (token.isNotEmpty) {
      options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } else {
      options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }
    return options;
  }
}
