import 'package:djamo_todo_tdd_test/features/todos/data/models/todo_model.dart';

abstract class TodoDataSource {
  Future<TodoModel?> getTodoFromDataSource(int id);
  Future<List<TodoModel>> getTodosFromDataSource();

  Future<TodoModel> updateTodoOnDataSource(
    int id, {
    String? body,
    String? title,
    bool? isCompleted,
  });

  Future<TodoModel> saveTodoOnDataSource({
    required String body,
    required String title,
  });

  Future<bool> deleteTodoFromDataSource(int id);

  Future<bool> deleteTodosFromDataSource(List<int> ids);
}
