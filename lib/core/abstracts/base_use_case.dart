import 'package:dartz/dartz.dart';
import 'package:mvvm_architecture_template/core/errors/failure.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
