import 'package:dartz/dartz.dart';
import 'package:djamo_todo_tdd_test/core/shared/exceptions.dart';
import 'package:djamo_todo_tdd_test/core/shared/failures.dart';
import 'package:djamo_todo_tdd_test/core/usecases/usecase.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/repositories/todo_repository.dart';
import 'package:equatable/equatable.dart';

class DeleteTodosUseCase implements UseCase<bool, DeleteTodosParams> {
  DeleteTodosUseCase(this.todoRepository);

  final TodoRepository todoRepository;

  @override
  String get identifier => 'delete_todos';

  @override
  Future<Either<Failure, bool>> call(DeleteTodosParams params) async {
    try {
      final isDeleted = await todoRepository.deleteTodos(params.ids);

      return Right(isDeleted);
    } on LocalDataError catch (_) {
      return Left(LocalDataFailure());
    }
  }
}

class DeleteTodosParams extends Equatable {
  const DeleteTodosParams(this.ids);

  final List<int> ids;

  @override
  List<Object?> get props => [ids];
}
