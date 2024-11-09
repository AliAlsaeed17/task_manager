import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/features/home/domain/models/todos_model.dart';
import 'package:task_manager/core/usecases/base_usecase.dart';
import 'package:task_manager/features/home/domain/repository/home_repository.dart';

class DeleteTodo extends BaseUseCase<int, TodoDataModel> {
  final HomeRepository _homeRepository;

  DeleteTodo(this._homeRepository);

  @override
  Future<Either<Failure, TodoDataModel>> execute(int params) async {
    return await _homeRepository.deleteTodo(params);
  }
}
