import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/features/auth/data/params/login_params.dart';
import 'package:task_manager/features/auth/domain/models/user_model.dart';
import 'package:task_manager/core/usecases/base_usecase.dart';
import 'package:task_manager/features/auth/domain/repository/auth_repository.dart';

class Login extends BaseUseCase<LoginParams, UserModel> {
  final AuthRepository _authRepository;

  Login(this._authRepository);

  @override
  Future<Either<Failure, UserModel>> execute(LoginParams params) async {
    return await _authRepository.login(params);
  }
}
