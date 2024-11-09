import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/features/home/data/params/add_new_todo_params.dart';
import 'package:task_manager/features/home/data/params/get_todos_params.dart';
import 'package:task_manager/features/home/data/params/update_todo_params.dart';
import 'package:task_manager/features/home/domain/models/todos_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, TodosModel>> getAllTodos(GetTodosParams params);

  Future<Either<Failure, TodoDataModel>> updateTodo(UpdateTodoParams params);

  Future<Either<Failure, TodoDataModel>> addNewTodo(AddNewTodoParams params);

  Future<Either<Failure, TodoDataModel>> deleteTodo(int params);
}
