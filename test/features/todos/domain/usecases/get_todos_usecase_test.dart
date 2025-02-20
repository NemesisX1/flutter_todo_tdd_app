import 'package:dartz/dartz.dart';
import 'package:flutter_todo_app/core/usecases/usecase.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';
import 'package:flutter_todo_app/features/todos/domain/repositories/todo_repository.dart';
import 'package:flutter_todo_app/features/todos/domain/usecases/get_todos_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/todos_fixture.dart';

class TodoRepositoryMock extends Mock implements TodoRepository {}

void main() {
  late GetTodosUseCase useCase;
  late TodoRepository todoRepository;

  group('Test on GetTodoSUseCase', () {
    setUpAll(() {
      todoRepository = TodoRepositoryMock();
      useCase = GetTodosUseCase(todoRepository);
    });

    test('if call return list of todos', () async {
      final todos = todosFixture.map(TodoMapper.fromMap).toList();

      when(() => todoRepository.getTodos()).thenAnswer(
        (_) => Future.value(todos),
      );

      final res = await useCase.call(NoParams());

      // ignore: inference_failure_on_instance_creation
      expect(res, Right(todos));
    });
  });
}
