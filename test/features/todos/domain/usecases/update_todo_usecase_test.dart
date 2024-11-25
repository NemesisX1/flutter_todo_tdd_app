import 'package:dartz/dartz.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/entities/todo.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/repositories/todo_repository.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/usecases/update_todo_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/todos_fixture.dart';

class TodoRepositoryMock extends Mock implements TodoRepository {}

void main() async {
  late UpdateTodoUseCase useCase;
  late TodoRepository todoRepository;

  group('Test on UpdateTodoUseCase', () {
    setUpAll(() {
      todoRepository = TodoRepositoryMock();
      useCase = UpdateTodoUseCase(todoRepository);
    });

    test('if call return Left', () async {
      final todo = TodoMapper.fromMap(todosFixture.first);

      when(() => todoRepository.updateTodo(todo)).thenAnswer(
        (_) => Future.value(
          todo,
        ),
      );

      final res = await useCase.call(UpdateTodoParams(todo));

      // ignore: inference_failure_on_instance_creation
      expect(res, Right(todo));
    });
  });
}
