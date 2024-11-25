import 'package:dartz/dartz.dart';
import 'package:djamo_todo_tdd_test/core/shared/exceptions.dart';
import 'package:djamo_todo_tdd_test/core/shared/failures.dart';
import 'package:djamo_todo_tdd_test/core/usecases/usecase.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/entities/todo.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/repositories/todo_repository.dart';

class GetTodosUseCase implements UseCase<List<Todo>, NoParams> {
  GetTodosUseCase(this.todoRepository);

  final TodoRepository todoRepository;

  @override
  String get identifier => 'get_todos';

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    try {
      final todos = await todoRepository.getTodos();

      return Right(todos);
    } on LocalDataError catch (_) {
      return Left(LocalDataFailure());
    }
  }
}
