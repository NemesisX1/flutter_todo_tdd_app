import 'package:flutter_todo_app/features/todos/data/datasources/todo_data_source.dart';
import 'package:flutter_todo_app/features/todos/data/models/todo_model.dart';
import 'package:isar/isar.dart';

class TodoLocalDataSourceImpl implements TodoDataSource {
  TodoLocalDataSourceImpl(this.isar);

  final Isar isar;

  @override
  Future<TodoModel?> getTodoFromDataSource(Id id) async {
    late TodoModel? todo;

    await isar.txn(() async {
      todo = await isar.todoModels.where().idEqualTo(id).findFirst();
    });
    return todo;
  }

  @override
  Future<List<TodoModel>> getTodosFromDataSource() async {
    late List<TodoModel> todos;

    await isar.txn(() async {
      todos = await isar.todoModels.where().findAll();
    });
    return todos;
  }

  @override
  Future<TodoModel> saveTodoOnDataSource({
    required String body,
    required String title,
    Id? id,
  }) async {
    final todo = TodoModel()
      ..body = body
      ..title = title
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();

    if (id != null) todo.id = id;

    await isar.writeTxn(
      () async {
        await isar.todoModels.put(
          todo,
        );
      },
    );

    return todo;
  }

  @override
  Future<TodoModel> updateTodoOnDataSource(
    Id id, {
    String? body,
    String? title,
    bool? isCompleted,
  }) async {
    final todo = TodoModel()
      ..id = id
      ..updatedAt = DateTime.now();

    if (body != null) todo.body = body;
    if (title != null) todo.title = title;
    if (isCompleted != null) todo.isCompleted = isCompleted;

    await isar.writeTxn(() async {
      await isar.todoModels.put(
        todo,
      );
    });

    return todo;
  }

  @override
  Future<bool> deleteTodoFromDataSource(Id id) async {
    var isDeleted = false;

    await isar.writeTxn(() async {
      isDeleted = await isar.todoModels.delete(
        id,
      );
    });

    return isDeleted;
  }

  @override
  Future<bool> deleteTodosFromDataSource(List<int> ids) async {
    var isDeleted = false;

    await isar.writeTxn(() async {
      final deletedCount = await isar.todoModels.deleteAll(
        ids,
      );

      isDeleted = deletedCount == ids.length;
    });

    return isDeleted;
  }
}
