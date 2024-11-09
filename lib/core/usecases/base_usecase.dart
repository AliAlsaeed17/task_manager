import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In params);
}
