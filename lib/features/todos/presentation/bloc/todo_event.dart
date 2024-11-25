part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class TodoEventFetchTodos extends TodoEvent {}

final class TodoEventAddTodo extends TodoEvent {
  TodoEventAddTodo(this.todo);
  final Todo todo;

  @override
  List<Object> get props => [todo];
}

final class TodoEventToogleDeletion extends TodoEvent {
  TodoEventToogleDeletion(this.todoId);
  final int todoId;

  @override
  List<Object> get props => [todoId];
}

final class TodoEventUpdateTodo extends TodoEvent {
  TodoEventUpdateTodo(this.todo);
  final Todo todo;

  @override
  List<Object> get props => [todo];
}

final class TodoEventDeleteTodos extends TodoEvent {
  TodoEventDeleteTodos(this.todoIds);
  final List<int> todoIds;

  @override
  List<Object> get props => [todoIds];
}
