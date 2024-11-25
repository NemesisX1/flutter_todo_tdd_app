import 'package:bloc/bloc.dart';
import 'package:djamo_todo_tdd_test/core/usecases/usecase.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/entities/todo.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/usecases/add_todo_usecase.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/usecases/delete_todos_usecase.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/usecases/get_todos_usecase.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/usecases/update_todo_usecase.dart';
import 'package:djamo_todo_tdd_test/locator.dart';
import 'package:equatable/equatable.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoEventFetchTodos>((event, emit) async {
      emit(TodoIsLoading());

      final getTodosUseCase = locator<GetTodosUseCase>();

      (await getTodosUseCase.call(NoParams())).fold(
        (failure) => emit(TodoHasError(failure)),
        (fechtedTodos) {
          todos = fechtedTodos;
          emit(TodoFetched(todos));
        },
      );
    });

    on<TodoEventAddTodo>((event, emit) async {
      emit(TodoIsLoading());

      final addTodoUseCase = locator<AddTodoUseCase>();

      (await addTodoUseCase.call(
        AddTodoParams(event.todo),
      ))
          .fold(
        (failure) => emit(TodoHasError(failure)),
        (todo) => emit(TodoInitial()),
      );
    });

    on<TodoEventUpdateTodo>((event, emit) async {
      emit(TodoIsLoading());

      final updateTodoUseCase = locator<UpdateTodoUseCase>();

      (await updateTodoUseCase.call(
        UpdateTodoParams(event.todo),
      ))
          .fold(
        (failure) => emit(TodoHasError(failure)),
        (todo) => emit(TodoInitial()),
      );
    });

    on<TodoEventToogleDeletion>((event, emit) {
      emit(TodoIsLoading());

      if (todoIdsToDelete.contains(event.todoId)) {
        todoIdsToDelete.remove(event.todoId);
      } else {
        todoIdsToDelete.add(event.todoId);
      }

      emit(TodoFetched(todos));
    });

    on<TodoEventDeleteTodos>((event, emit) async {
      emit(TodoIsLoading());

      final deleteTodosUseCase = locator<DeleteTodosUseCase>();

      (await deleteTodosUseCase.call(
        DeleteTodosParams(event.todoIds),
      ))
          .fold(
        (failure) => emit(TodoHasError(failure)),
        (isDeleted) {
          todoIdsToDelete.clear();
          emit(TodoInitial());
        },
      );
    });
  }

  List<Todo> todos = [];
  List<int> todoIdsToDelete = [];
}
