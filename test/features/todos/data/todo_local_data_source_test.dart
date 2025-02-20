import 'package:flutter_todo_app/features/todos/data/datasources/todo_local_data_source.dart';
import 'package:flutter_todo_app/features/todos/data/models/todo_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import '../fixtures/todos_fixture.dart';

void main() {
  late Isar isar;
  late TodoLocalDataSourceImpl todoDataSource;

  group('Test on TodoLocalDataSource', () {
    setUpAll(() async {
      await Isar.initializeIsarCore(download: true);

      isar = Isar.openSync(
        [TodoModelSchema],
        name: 'isar_test',
        directory: 'test/features/todos/data',
      );
      todoDataSource = TodoLocalDataSourceImpl(isar);
    });

    final todoFixture = todosFixture.first;
    TodoModel? localTodo;

    test('test if saveTodoOnDataSource works', () {
      final saveTodoFuture = todoDataSource.saveTodoOnDataSource(
        id: todoFixture['id']! as int,
        title: todoFixture['title']! as String,
        body: todoFixture['body']! as String,
      );

      expect(saveTodoFuture, completion(isNot(throwsException)));
    });

    test('test if get getTodoFromDataSource works', () async {
      localTodo =
          await todoDataSource.getTodoFromDataSource(todoFixture['id']! as int);

      expect(localTodo, isNotNull);
      expect(localTodo!.id, todoFixture['id']! as int);
      expect(localTodo!.title, todoFixture['title']! as String);
      expect(localTodo!.body, todoFixture['body']! as String);
    });

    test('test if updateTodoOnDataSource works', () async {
      await todoDataSource.updateTodoOnDataSource(
        todoFixture['id']! as int,
        body: localTodo!.body,
        title: localTodo!.title,
        isCompleted: true,
      );

      localTodo =
          await todoDataSource.getTodoFromDataSource(todoFixture['id']! as int);

      expect(localTodo, isNotNull);
      expect(localTodo!.isCompleted, true);
    });

    test('test if deleteTodosFromDataSource works', () async {
      final deleted = await todoDataSource.deleteTodosFromDataSource(
        [todoFixture['id']! as int],
      );

      expect(deleted, true);
    });

    tearDownAll(() {
      isar.writeTxnSync(() {
        isar.clearSync();
      });
    });
  });
}
