import 'package:task_manager/core/network/app_api.dart';
import 'package:task_manager/core/network/api_endpoints.dart';
import 'package:task_manager/features/auth/data/params/login_params.dart';
import 'package:task_manager/features/auth/data/params/token_params.dart';
import 'package:task_manager/features/auth/data/response/token_response.dart';
import 'package:task_manager/features/auth/data/response/user_response.dart';

abstract class AuthRemoteDataSource {
  Future<TokenResponse> getRefreshToken(TokenParams params);

  Future<UserResponse> login(LoginParams params);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final AppServiceClient _appServiceClient;

  AuthRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<TokenResponse> getRefreshToken(TokenParams params) async {
    return await _appServiceClient.performPostRequest(
      ApiEndpoints.refreshAuthToken,
      params.toJson(),
      TokenResponse.fromJson,
    );
  }

  @override
  Future<UserResponse> login(LoginParams params) async {
    return await _appServiceClient.performPostRequest(
      ApiEndpoints.login,
      params.toJson(),
      UserResponse.fromJson,
    );
  }
}
