import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/features/auth/data/params/login_params.dart';
import 'package:task_manager/features/auth/domain/models/token_model.dart';
import 'package:task_manager/features/auth/domain/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, Token>> refreshUserToken();

  Future<Either<Failure, UserModel>> login(LoginParams params);
}
