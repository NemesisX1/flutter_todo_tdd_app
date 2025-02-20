import 'dart:developer';
import 'package:flutter_todo_app/core/shared/exceptions.dart';
import 'package:flutter_todo_app/features/todos/data/datasources/todo_data_source.dart';
import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';
import 'package:flutter_todo_app/features/todos/domain/repositories/todo_repository.dart';
import 'package:flutter/foundation.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this.dataSource);

  final TodoDataSource dataSource;

  @override
  Future<List<Todo>> getTodos() async {
    final todos = <Todo>[];

    try {
      final todosModel = await dataSource.getTodosFromDataSource();

      for (final todoModel in todosModel) {
        todos.add(todoModel.toEntity);
      }
    } catch (e, stack) {
      if (kDebugMode) {
        log('$e');
        log(stack.toString());
      }

      throw LocalDataError();
    }

    return todos;
  }

  @override
  Future<Todo> saveTodo(Todo todo) async {
    try {
      final savedTodo = await dataSource.saveTodoOnDataSource(
        body: todo.body,
        title: todo.title,
      );

      return savedTodo.toEntity;
    } catch (e, stack) {
      if (kDebugMode) {
        log('$e');
        log(stack.toString());
      }

      throw LocalDataError();
    }
  }

  @override
  Future<Todo> updateTodo(Todo todo) async {
    try {
      final savedTodo = await dataSource.updateTodoOnDataSource(
        todo.id!,
        body: todo.body,
        title: todo.title,
        isCompleted: todo.isCompleted,
      );

      return savedTodo.toEntity;
    } catch (e, stack) {
      if (kDebugMode) {
        log('$e');
        log(stack.toString());
      }

      throw LocalDataError();
    }
  }

  @override
  Future<bool> deleteTodos(List<int> ids) async {
    try {
      final isDeleted = await dataSource.deleteTodosFromDataSource(ids);

      return isDeleted;
    } catch (e, stack) {
      if (kDebugMode) {
        log('$e');
        log(stack.toString());
      }

      throw LocalDataError();
    }
  }
}
