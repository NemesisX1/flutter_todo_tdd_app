import 'package:djamo_todo_tdd_test/features/todos/domain/entities/todo.dart';
import 'package:djamo_todo_tdd_test/features/todos/presentation/bloc/todo_bloc.dart';
import 'package:djamo_todo_tdd_test/features/todos/presentation/widgets/todo_operation_bottom_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TodoListTile extends StatefulWidget {
  const TodoListTile({
    required this.todo,
    this.onLongPress,
    super.key,
  });

  final Todo todo;

  final void Function(Todo todo)? onLongPress;

  @override
  // ignore: library_private_types_in_public_api
  _TodoListTileState createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  bool _isChecked = false;
  bool _isSelected = false;

  @override
  void initState() {
    _isChecked = widget.todo.isCompleted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedTileColor: Colors.red.shade100,
      selected: _isSelected,
      onLongPress: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onLongPress?.call(widget.todo);
      },
      onTap: () {
        context.push(
          '/details',
          extra: widget.todo,
        );
      },
      leading: Checkbox(
        value: _isChecked,
        onChanged: (value) {
          setState(() {
            _isChecked = value!;
          });
          context.read<TodoBloc>().add(
                TodoEventUpdateTodo(
                  widget.todo.copyWith(isCompleted: value),
                ),
              );
        },
      ),
      title: Text(
        widget.todo.title,
        style: TextStyle(
          decoration:
              _isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          if (_isSelected) {
            showDialog<bool>(
              context: context,
              builder: (context) => _DeleteTodoDialog(),
            ).then((shouldDelete) {
              if (shouldDelete! && context.mounted) {
                context.read<TodoBloc>().add(
                      TodoEventDeleteTodos([widget.todo.id!]),
                    );
              }
            });
          } else {
            showModalBottomSheet<Todo?>(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              showDragHandle: true,
              useRootNavigator: true,
              builder: (_) => TodoOperationBottomSheet(
                todo: widget.todo,
              ),
            ).then((todo) {
              if (todo != null && context.mounted) {
                context.read<TodoBloc>().add(
                      TodoEventUpdateTodo(
                        widget.todo.copyWith(
                          body: todo.body,
                          title: todo.title,
                        ),
                      ),
                    );
              }
            });
          }
        },
        icon: _isSelected
            ? const Icon(
                CupertinoIcons.trash,
                color: Colors.red,
              )
            : Icon(
                CupertinoIcons.pen,
                color: Theme.of(context).primaryColor,
              ),
      ),
    );
  }
}

class _DeleteTodoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete this task ?',
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
