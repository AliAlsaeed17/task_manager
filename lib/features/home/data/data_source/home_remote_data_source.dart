import 'package:task_manager/core/network/app_api.dart';
import 'package:task_manager/core/network/api_endpoints.dart';
import 'package:task_manager/features/home/data/params/add_new_todo_params.dart';
import 'package:task_manager/features/home/data/params/get_todos_params.dart';
import 'package:task_manager/features/home/data/params/update_todo_params.dart';
import 'package:task_manager/features/home/data/response/todos_response.dart';

abstract class HomeRemoteDataSource {
  Future<TodosResponse> getAllTodos(GetTodosParams params);

  Future<TodoDataResponse> updateTodo(UpdateTodoParams params);

  Future<TodoDataResponse> addNewTodo(AddNewTodoParams params);

  Future<TodoDataResponse> deleteTodo(int id);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final AppServiceClient _appServiceClient;

  HomeRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<TodosResponse> getAllTodos(GetTodosParams params) async {
    return await _appServiceClient.performGetRequest(
      ApiEndpoints.todos,
      TodosResponse.fromJson,
      params: params.toJson(),
    );
  }

  @override
  Future<TodoDataResponse> updateTodo(UpdateTodoParams params) async {
    return await _appServiceClient.performPutRequest(
      '${ApiEndpoints.todos}/${params.id}',
      TodoDataResponse.fromJson,
      params: {'completed': params.completed},
    );
  }

  @override
  Future<TodoDataResponse> addNewTodo(AddNewTodoParams params) async {
    return await _appServiceClient.performPostRequest(
      ApiEndpoints.addTodo,
      params.toJson(),
      TodoDataResponse.fromJson,
    );
  }

  @override
  Future<TodoDataResponse> deleteTodo(int id) async {
    return await _appServiceClient.performDeleteRequest(
      '${ApiEndpoints.todos}/$id',
      fromJson: TodoDataResponse.fromJson,
    );
  }
}
