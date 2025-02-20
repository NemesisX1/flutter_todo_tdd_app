import 'package:dartz/dartz.dart';
import 'package:flutter_todo_app/core/shared/exceptions.dart';
import 'package:flutter_todo_app/core/shared/failures.dart';
import 'package:flutter_todo_app/core/usecases/usecase.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';
import 'package:flutter_todo_app/features/todos/domain/repositories/todo_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateTodoUseCase implements UseCase<Todo, UpdateTodoParams> {
  UpdateTodoUseCase(this.todoRepository);

  final TodoRepository todoRepository;

  @override
  String get identifier => 'update_todo';

  @override
  Future<Either<Failure, Todo>> call(UpdateTodoParams params) async {
    try {
      final todo = await todoRepository.updateTodo(params.todo);

      return Right(todo);
    } on LocalDataError catch (_) {
      return Left(LocalDataFailure());
    }
  }
}

class UpdateTodoParams extends Equatable {
  const UpdateTodoParams(this.todo);

  final Todo todo;

  @override
  List<Object?> get props => [todo];
}
