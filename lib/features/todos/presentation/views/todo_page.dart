import 'package:djamo_todo_tdd_test/features/todos/domain/entities/todo.dart';
import 'package:djamo_todo_tdd_test/features/todos/presentation/bloc/todo_bloc.dart';
import 'package:djamo_todo_tdd_test/features/todos/presentation/widgets/loader_widget.dart';
import 'package:djamo_todo_tdd_test/features/todos/presentation/widgets/todo_list_tile_widget.dart';
import 'package:djamo_todo_tdd_test/features/todos/presentation/widgets/todo_operation_bottom_sheet_widget.dart';
import 'package:djamo_todo_tdd_test/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<TodoBloc>(),
      child: const TodoView(),
    );
  }
}

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bienvenue  📝',
        ),
        actions: [
          if (context.watch<TodoBloc>().todoIdsToDelete.isEmpty)
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                context.read<TodoBloc>().add(TodoEventFetchTodos());
              },
              icon: Icon(
                CupertinoIcons.refresh,
                color: Theme.of(context).primaryColor,
              ),
            )
          else
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (context) => _DeleteTodosDialog(),
                ).then((shouldDelete) {
                  if (shouldDelete! && context.mounted) {
                    context.read<TodoBloc>().add(
                          TodoEventDeleteTodos(
                            context.read<TodoBloc>().todoIdsToDelete,
                          ),
                        );
                  }
                });
              },
              icon: const Icon(
                CupertinoIcons.trash_fill,
                color: Colors.red,
              ),
            ),
          const Gap(20),
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoInitial) {
            context.read<TodoBloc>().add(TodoEventFetchTodos());
          }

          if (state is TodoIsLoading) return const LoaderWidget();

          if (state is TodoHasError) {
            return const Center(
              child: Text('Une erreur est survenue !'),
            );
          }

          if (state is TodoFetched) {
            if (state.todos.isEmpty) {
              return Center(
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.add,
                  ),
                  label: const Text(
                    'Ajoutez une première tâche',
                  ),
                  onPressed: () {
                    _showTodoModal(context);
                  },
                ),
              );
            }

            return SingleChildScrollView(
              child: Wrap(
                children: state.todos
                    .map<Widget>(
                      (todo) => TodoListTile(
                        todo: todo,
                        onLongPress: (todo) {
                          context
                              .read<TodoBloc>()
                              .add(TodoEventToogleDeletion(todo.id!));
                        },
                      ),
                    )
                    .toList(),
              ),
            );
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: context.watch<TodoBloc>().todos.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                _showTodoModal(context);
              },
              child: const Icon(
                CupertinoIcons.add,
              ),
            )
          : const SizedBox(),
    );
  }

  void _showTodoModal(BuildContext context) {
    showModalBottomSheet<Todo?>(
      context: context,
      builder: (_) => TodoOperationBottomSheet(),
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      useRootNavigator: true,
    ).then(
      (value) {
        if (value != null && context.mounted) {
          context.read<TodoBloc>().add(TodoEventAddTodo(value));
        }
      },
    );
  }
}

class _DeleteTodosDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete these tasks ?',
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            context.pop(true);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text(
            'Yes',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context.pop(false);
          },
          child: const Text(
            'Non',
          ),
        ),
      ],
    );
  }
}
