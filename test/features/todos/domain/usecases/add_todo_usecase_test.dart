import 'package:dartz/dartz.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/entities/todo.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/repositories/todo_repository.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/usecases/add_todo_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/todos_fixture.dart';

class TodoRepositoryMock extends Mock implements TodoRepository {}

void main() async {
  late AddTodoUseCase useCase;
  late TodoRepository todoRepository;

  group('Test on AddTodoSUseCase', () {
    setUpAll(() {
      todoRepository = TodoRepositoryMock();
      useCase = AddTodoUseCase(todoRepository);
    });

    test('if call return Left', () async {
      final todo = TodoMapper.fromMap(todosFixture.first);

      when(() => todoRepository.saveTodo(todo)).thenAnswer(
        (_) => Future.value(
          todo,
        ),
      );

      final res = await useCase.call(AddTodoParams(todo));

      // ignore: inference_failure_on_instance_creation
      expect(res, Right(todo));
    });
  });
}
