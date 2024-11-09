import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/features/home/data/params/update_todo_params.dart';
import 'package:task_manager/features/home/domain/models/todos_model.dart';
import 'package:task_manager/core/usecases/base_usecase.dart';
import 'package:task_manager/features/home/domain/repository/home_repository.dart';

class UpdateTodo extends BaseUseCase<UpdateTodoParams, TodoDataModel> {
  final HomeRepository _homeRepository;

  UpdateTodo(this._homeRepository);

  @override
  Future<Either<Failure, TodoDataModel>> execute(
      UpdateTodoParams params) async {
    return await _homeRepository.updateTodo(params);
  }
}
