import 'package:dartz/dartz.dart';
import 'package:djamo_todo_tdd_test/core/shared/exceptions.dart';
import 'package:djamo_todo_tdd_test/core/shared/failures.dart';
import 'package:djamo_todo_tdd_test/core/usecases/usecase.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/entities/todo.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/repositories/todo_repository.dart';
import 'package:equatable/equatable.dart';

class AddTodoUseCase implements UseCase<Todo, AddTodoParams> {
  AddTodoUseCase(this.todoRepository);

  final TodoRepository todoRepository;

  @override
  String get identifier => 'add_todo';

  @override
  Future<Either<Failure, Todo>> call(AddTodoParams params) async {
    try {
      final todo = await todoRepository.saveTodo(params.todo);

      return Right(todo);
    } on LocalDataError catch (_) {
      return Left(LocalDataFailure());
    }
  }
}

class AddTodoParams extends Equatable {
  const AddTodoParams(this.todo);

  final Todo todo;

  @override
  List<Object?> get props => [todo];
}
