import 'package:dartz/dartz.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/entities/todo.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/repositories/todo_repository.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/usecases/delete_todos_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/todos_fixture.dart';

class TodoRepositoryMock extends Mock implements TodoRepository {}

void main() async {
  late DeleteTodosUseCase useCase;
  late TodoRepository todoRepository;

  group('Test on DeleteTodoSUseCase', () {
    setUpAll(() {
      todoRepository = TodoRepositoryMock();
      useCase = DeleteTodosUseCase(todoRepository);
    });

    test('if call return Left', () async {
      final id = TodoMapper.fromMap(todosFixture.first).id!;

      when(() => todoRepository.deleteTodos([id])).thenAnswer(
        (_) => Future.value(true),
      );

      final res = await useCase.call(
        DeleteTodosParams([id]),
      );

      // ignore: inference_failure_on_instance_creation
      expect(res, const Right(true));
    });
  });
}
