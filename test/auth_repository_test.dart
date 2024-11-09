import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:task_manager/core/utils/app_pref.dart';
import 'package:task_manager/core/errors/error_handler.dart';
import 'package:task_manager/core/network/network_info.dart';
import 'package:task_manager/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:task_manager/features/auth/data/mapper/auth_mapper.dart';
import 'package:task_manager/features/auth/data/params/login_params.dart';
import 'package:task_manager/features/auth/data/repository/auth_repository_impl.dart';
import 'package:task_manager/features/auth/data/response/token_response.dart';
import 'package:task_manager/features/auth/data/response/user_response.dart';
import 'package:task_manager/features/auth/domain/models/token_model.dart';
import 'package:task_manager/features/auth/domain/models/user_model.dart';
import 'auth_repository_test.mocks.dart';

// Generate the mock classes
@GenerateMocks([NetworkInfo, AppPreferences, AuthRemoteDataSource])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockAppPreferences mockAppPreferences;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockAppPreferences = MockAppPreferences();
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(
        mockAuthRemoteDataSource, mockAppPreferences, mockNetworkInfo);
  });

  group('AuthRepositoryImpl', () {
    final tokenResponse =
        TokenResponse(token: 'accessToken', refreshToken: 'refreshToken');
    final loginParams =
        LoginParams(userName: 'test', password: 'password', expiresInMins: 30);
    final userResponse = UserResponse(
      id: 1,
      userName: 'Test User',
      email: 'test@test.com',
      token: 'token',
      image: 'image',
      firstName: 'Test',
      lastName: 'User',
      gender: 'Male',
      refreshToken: 'refreshToken',
    );

    group('refreshUserToken', () {
      test(
          'should return TokenModel when the call to remote data source is successful',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        when(mockAppPreferences.getUserRefreshToken())
            .thenReturn('refreshToken');
        when(mockAuthRemoteDataSource.getRefreshToken(any))
            .thenAnswer((_) async => tokenResponse);

        // Act
        final result = await repository.refreshUserToken();

        // Assert
        expect(result, Right<Failure, Token>(tokenResponse.toDomain()));
        verify(mockNetworkInfo.isConnected)
            .called(1); // Correctly verifying the call
        verify(mockAppPreferences.getUserRefreshToken()).called(1);
        verify(mockAuthRemoteDataSource.getRefreshToken(any))
            .called(1); // Adjusted for any arguments
      });

      test(
          'should return Failure when the call to remote data source is unsuccessful',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        when(mockAppPreferences.getUserRefreshToken())
            .thenReturn('refreshToken');
        when(mockAuthRemoteDataSource.getRefreshToken(any))
            .thenThrow(Exception());

        // Act
        final result = await repository.refreshUserToken();

        // Assert
        expect(result,
            Left<Failure, Token>(ErrorHandler.handle(Exception()).failure));
        verify(mockNetworkInfo.isConnected)
            .called(1); // Correctly verifying the call
        verify(mockAppPreferences.getUserRefreshToken()).called(1);
        verify(mockAuthRemoteDataSource.getRefreshToken(any))
            .called(1); // Adjusted for any arguments
      });

      test('should return Failure when there is no internet connection',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => false);

        // Act
        final result = await repository.refreshUserToken();

        // Assert
        expect(result,
            Left<Failure, Token>(DataSource.noInternetConnection.getFailure()));
        verify(mockNetworkInfo.isConnected)
            .called(1); // Correctly verifying the call
        verifyNever(mockAppPreferences.getUserRefreshToken());
        verifyNever(mockAuthRemoteDataSource
            .getRefreshToken(any)); // Adjusted for any arguments
      });
    });

    group('login', () {
      test(
          'should return UserModel when the call to remote data source is successful',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        when(mockAuthRemoteDataSource.login(any))
            .thenAnswer((_) async => userResponse);

        // Act
        final result = await repository.login(loginParams);

        // Assert
        expect(result, Right<Failure, UserModel>(userResponse.toDomain()));
        verify(mockNetworkInfo.isConnected);
        verify(mockAuthRemoteDataSource.login(loginParams));
      });

      test(
          'should return Failure when the call to remote data source is unsuccessful',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        when(mockAuthRemoteDataSource.login(any)).thenThrow(Exception());

        // Act
        final result = await repository.login(loginParams);

        // Assert
        expect(result,
            Left<Failure, UserModel>(ErrorHandler.handle(Exception()).failure));
        verify(await mockNetworkInfo.isConnected);
        verify(mockAuthRemoteDataSource.login(loginParams));
      });

      test('should return Failure when there is no internet connection',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => false);

        // Act
        final result = await repository.login(loginParams);

        // Assert
        expect(
            result,
            Left<Failure, UserModel>(
                DataSource.noInternetConnection.getFailure()));
        verify(mockNetworkInfo.isConnected);
        verifyNever(mockAuthRemoteDataSource.login(any));
      });
    });
  });
}
