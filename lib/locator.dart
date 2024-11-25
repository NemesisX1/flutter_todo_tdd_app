import 'package:djamo_todo_tdd_test/features/todos/data/datasources/todo_data_source.dart';
import 'package:djamo_todo_tdd_test/features/todos/data/datasources/todo_local_data_source.dart';
import 'package:djamo_todo_tdd_test/features/todos/data/models/todo_model.dart';
import 'package:djamo_todo_tdd_test/features/todos/data/repositories/todo_repository_impl.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/repositories/todo_repository.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/usecases/add_todo_usecase.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/usecases/delete_todos_usecase.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/usecases/get_todos_usecase.dart';
import 'package:djamo_todo_tdd_test/features/todos/domain/usecases/update_todo_usecase.dart';
import 'package:djamo_todo_tdd_test/features/todos/presentation/bloc/todo_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator({bool testMode = false}) async {
  late Isar isarInstance;

  if (testMode) {
    isarInstance = await Isar.open(
      [TodoModelSchema],
      directory: '.',
    );
  } else {
    final dir = await getApplicationDocumentsDirectory();
    isarInstance = await Isar.open(
      [TodoModelSchema],
      directory: dir.path,
    );
  }

  locator

    /// register Bloc
    ..registerFactory(
      TodoBloc.new,
    )

    /// register usecases
    ..registerLazySingleton(
      () => GetTodosUseCase(locator()),
    )
    ..registerLazySingleton(
      () => UpdateTodoUseCase(locator()),
    )
    ..registerLazySingleton(
      () => AddTodoUseCase(locator()),
    )
    ..registerLazySingleton(
      () => DeleteTodosUseCase(locator()),
    )

    /// register repository
    ..registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(
        locator(),
      ),
    )

    /// register data source
    ..registerLazySingleton<Isar>(
      () => isarInstance,
    )
    ..registerLazySingleton<TodoDataSource>(
      () => TodoLocalDataSourceImpl(
        locator(),
      ),
    );
}
