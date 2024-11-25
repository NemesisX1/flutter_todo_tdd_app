import 'package:dartz/dartz.dart';
import 'package:djamo_todo_tdd_test/core/shared/failures.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  String get identifier;
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
