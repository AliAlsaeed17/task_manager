import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/features/home/data/params/add_new_todo_params.dart';
import 'package:task_manager/features/home/domain/models/todos_model.dart';
import 'package:task_manager/core/usecases/base_usecase.dart';
import 'package:task_manager/features/home/domain/repository/home_repository.dart';

class AddNewTodo extends BaseUseCase<AddNewTodoParams, TodoDataModel> {
  final HomeRepository _homeRepository;

  AddNewTodo(this._homeRepository);

  @override
  Future<Either<Failure, TodoDataModel>> execute(
      AddNewTodoParams params) async {
    return await _homeRepository.addNewTodo(params);
  }
}
