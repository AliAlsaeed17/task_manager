import 'package:dartz/dartz.dart';
import 'package:task_manager/core/utils/app_pref.dart';
import 'package:task_manager/core/errors/error_handler.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/core/network/network_info.dart';
import 'package:task_manager/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:task_manager/features/auth/data/mapper/auth_mapper.dart';
import 'package:task_manager/features/auth/data/params/login_params.dart';
import 'package:task_manager/features/auth/data/params/token_params.dart';
import 'package:task_manager/features/auth/domain/models/token_model.dart';
import 'package:task_manager/features/auth/domain/models/user_model.dart';
import 'package:task_manager/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._appPreferences,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, Token>> refreshUserToken() async {
    if (await _networkInfo.isConnected()) {
      try {
        final params = TokenParams(
          refreshToken: _appPreferences.getUserRefreshToken(),
          expiresInMins: 30,
        );
        final response = await _authRemoteDataSource.getRefreshToken(params);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> login(LoginParams params) async {
    if (await _networkInfo.isConnected()) {
      try {
        final response = await _authRemoteDataSource.login(params);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
