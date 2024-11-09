import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/network/network_info.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/core/errors/error_handler.dart';
import 'package:task_manager/core/utils/app_pref.dart';
import 'package:mockito/annotations.dart';
import 'package:task_manager/features/home/data/data_source/home_remote_data_source.dart';
import 'package:task_manager/features/home/data/mapper/home_mapper.dart';
import 'package:task_manager/features/home/data/params/add_new_todo_params.dart';
import 'package:task_manager/features/home/data/params/get_todos_params.dart';
import 'package:task_manager/features/home/data/params/update_todo_params.dart';
import 'package:task_manager/features/home/data/repository/home_repository_impl.dart';
import 'package:task_manager/features/home/data/response/todos_response.dart';
import 'package:task_manager/features/home/domain/models/todos_model.dart';
import 'home_repository_test.mocks.dart';

// Generate the mock classes
@GenerateMocks([NetworkInfo, AppPreferences, HomeRemoteDataSource])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockAppPreferences mockAppPreferences;
  late MockHomeRemoteDataSource mockHomeRemoteDataSource;
  late HomeRepositoryImpl repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockAppPreferences = MockAppPreferences();
    mockHomeRemoteDataSource = MockHomeRemoteDataSource();
    repository = HomeRepositoryImpl(
        mockHomeRemoteDataSource, mockAppPreferences, mockNetworkInfo);
  });

  final todoDataResponse = TodoDataResponse(
    id: 1,
    completed: false,
    todo: 'Test Todo',
    userId: 1,
  );
  final todosResponse =
      TodosResponse(todos: [todoDataResponse], limit: 1, skip: 0, total: 1);

  final getTodosParams = GetTodosParams(limit: 10, skip: 0);
  final updateTodoParams = UpdateTodoParams(id: 1, completed: true);
  final addNewTodoParams =
      AddNewTodoParams(todo: 'New Todo', userId: 1, completed: false);

  group('HomeRepositoryImpl', () {
    group('getAllTodos', () {
      test(
        'should return TodosModel when the call to remote data source is successful',
        () async {
          // Arrange
          when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
          when(mockHomeRemoteDataSource.getAllTodos(getTodosParams))
              .thenAnswer((_) async => todosResponse);

          // Act
          final result = await repository.getAllTodos(getTodosParams);

          // Assert
          expect(result, Right<Failure, TodosModel>(todosResponse.toDomain()));
          verify(mockNetworkInfo.isConnected).called(1);
          verify(mockHomeRemoteDataSource.getAllTodos(getTodosParams))
              .called(1);
        },
      );

      test(
          'should return TodosModel from cache when there is no internet connection',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => false);
        when(mockAppPreferences.getTodoList())
            .thenReturn([todoDataResponse.toDomain()]);

        // Act
        final result = await repository.getAllTodos(getTodosParams);

        // Assert
        expect(
            result,
            Right<Failure, TodosModel>(TodosModel(
                todos: [todoDataResponse.toDomain()],
                limit: 0,
                skip: 0,
                total: 0)));
        verify(mockNetworkInfo.isConnected).called(1);
        verifyNever(mockHomeRemoteDataSource.getAllTodos(any));
      });

      test('should return Failure when the call to remote data source fails',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        when(mockHomeRemoteDataSource.getAllTodos(any)).thenThrow(Exception());

        // Act
        final result = await repository.getAllTodos(getTodosParams);

        // Assert
        expect(
            result,
            Left<Failure, TodosModel>(
                ErrorHandler.handle(Exception()).failure));
        verify(mockNetworkInfo.isConnected).called(1);
        verify(mockHomeRemoteDataSource.getAllTodos(getTodosParams)).called(1);
      });
    });

    group('updateTodo', () {
      test(
          'should return TodoDataModel when the call to remote data source is successful',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        when(mockHomeRemoteDataSource.updateTodo(any))
            .thenAnswer((_) async => todoDataResponse);

        // Act
        final result = await repository.updateTodo(updateTodoParams);

        // Assert
        expect(
            result, Right<Failure, TodoDataModel>(todoDataResponse.toDomain()));
        verify(mockNetworkInfo.isConnected).called(1);
        verify(mockHomeRemoteDataSource.updateTodo(updateTodoParams)).called(1);
      });

      test('should return Failure when the call to remote data source fails',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        when(mockHomeRemoteDataSource.updateTodo(any)).thenThrow(Exception());

        // Act
        final result = await repository.updateTodo(updateTodoParams);

        // Assert
        expect(
            result,
            Left<Failure, TodoDataModel>(
                ErrorHandler.handle(Exception()).failure));
        verify(mockNetworkInfo.isConnected).called(1);
        verify(mockHomeRemoteDataSource.updateTodo(updateTodoParams)).called(1);
      });

      test('should return Failure when there is no internet connection',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => false);

        // Act
        final result = await repository.updateTodo(updateTodoParams);

        // Assert
        expect(
            result,
            Left<Failure, TodoDataModel>(
                DataSource.noInternetConnection.getFailure()));
        verify(mockNetworkInfo.isConnected).called(1);
        verifyNever(mockHomeRemoteDataSource.updateTodo(any));
      });
    });

    group('addNewTodo', () {
      test(
          'should return TodoDataModel when the call to remote data source is successful',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        when(mockHomeRemoteDataSource.addNewTodo(any))
            .thenAnswer((_) async => todoDataResponse);

        // Act
        final result = await repository.addNewTodo(addNewTodoParams);

        // Assert
        expect(
            result, Right<Failure, TodoDataModel>(todoDataResponse.toDomain()));
        verify(mockNetworkInfo.isConnected).called(1);
        verify(mockHomeRemoteDataSource.addNewTodo(addNewTodoParams)).called(1);
      });

      test('should return Failure when the call to remote data source fails',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        when(mockHomeRemoteDataSource.addNewTodo(any)).thenThrow(Exception());

        // Act
        final result = await repository.addNewTodo(addNewTodoParams);

        // Assert
        expect(
            result,
            Left<Failure, TodoDataModel>(
                ErrorHandler.handle(Exception()).failure));
        verify(mockNetworkInfo.isConnected).called(1);
        verify(mockHomeRemoteDataSource.addNewTodo(addNewTodoParams)).called(1);
      });

      test('should return Failure when there is no internet connection',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => false);

        // Act
        final result = await repository.addNewTodo(addNewTodoParams);

        // Assert
        expect(
            result,
            Left<Failure, TodoDataModel>(
                DataSource.noInternetConnection.getFailure()));
        verify(mockNetworkInfo.isConnected).called(1);
        verifyNever(mockHomeRemoteDataSource.addNewTodo(any));
      });
    });

    group('deleteTodo', () {
      test(
          'should return TodoDataModel when the call to remote data source is successful',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        when(mockHomeRemoteDataSource.deleteTodo(any))
            .thenAnswer((_) async => todoDataResponse);

        // Act
        final result = await repository.deleteTodo(1);

        // Assert
        expect(
            result, Right<Failure, TodoDataModel>(todoDataResponse.toDomain()));
        verify(mockNetworkInfo.isConnected).called(1);
        verify(mockHomeRemoteDataSource.deleteTodo(1)).called(1);
      });

      test('should return Failure when the call to remote data source fails',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        when(mockHomeRemoteDataSource.deleteTodo(any)).thenThrow(Exception());

        // Act
        final result = await repository.deleteTodo(1);

        // Assert
        expect(
            result,
            Left<Failure, TodoDataModel>(
                ErrorHandler.handle(Exception()).failure));
        verify(mockNetworkInfo.isConnected).called(1);
        verify(mockHomeRemoteDataSource.deleteTodo(1)).called(1);
      });

      test('should return Failure when there is no internet connection',
          () async {
        // Arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => false);

        // Act
        final result = await repository.deleteTodo(1);

        // Assert
        expect(
            result,
            Left<Failure, TodoDataModel>(
                DataSource.noInternetConnection.getFailure()));
        verify(mockNetworkInfo.isConnected).called(1);
        verifyNever(mockHomeRemoteDataSource.deleteTodo(1));
      });
    });
  });
}
