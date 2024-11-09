import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/core/usecases/base_usecase.dart';
import 'package:task_manager/features/home/data/params/get_todos_params.dart';
import 'package:task_manager/features/home/domain/models/todos_model.dart';
import 'package:task_manager/features/home/domain/repository/home_repository.dart';

class GetAllTodos extends BaseUseCase<GetTodosParams, TodosModel> {
  final HomeRepository _homeRepository;

  GetAllTodos(this._homeRepository);

  @override
  Future<Either<Failure, TodosModel>> execute(GetTodosParams params) async {
    return await _homeRepository.getAllTodos(params);
  }
}
