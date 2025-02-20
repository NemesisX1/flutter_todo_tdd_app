import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
  Future<Todo> saveTodo(Todo todo);
  Future<bool> deleteTodos(List<int> ids);
  Future<Todo> updateTodo(Todo todo);
}
