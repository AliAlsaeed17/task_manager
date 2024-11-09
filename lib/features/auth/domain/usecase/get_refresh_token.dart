import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/features/auth/domain/models/token_model.dart';
import 'package:task_manager/core/usecases/base_usecase.dart';
import 'package:task_manager/features/auth/domain/repository/auth_repository.dart';

class GetRefreshToken extends BaseUseCase<void, Token> {
  final AuthRepository _authRepository;

  GetRefreshToken(this._authRepository);

  @override
  Future<Either<Failure, Token>> execute(void params) async {
    return await _authRepository.refreshUserToken();
  }
}
