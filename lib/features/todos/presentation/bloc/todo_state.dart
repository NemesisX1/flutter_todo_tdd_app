part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

final class TodoIsLoading extends TodoState {}

final class TodoFetched extends TodoState {
  TodoFetched(this.todos);

  final List<Todo> todos;

  @override
  List<Object> get props => [todos];
}

final class TodoHasError extends TodoState {
  TodoHasError(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}
