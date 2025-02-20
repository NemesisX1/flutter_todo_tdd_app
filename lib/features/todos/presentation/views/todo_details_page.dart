import 'package:flutter_todo_app/features/todos/domain/entities/todo.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todo_bloc.dart';
import 'package:flutter_todo_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class TodoDetailsPage extends StatelessWidget {
  const TodoDetailsPage(
    this.todo, {
    super.key,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<TodoBloc>(),
      child: TodoDetailsView(
        todo,
      ),
    );
  }
}

class TodoDetailsView extends StatelessWidget {
  const TodoDetailsView(this.todo, {super.key});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          todo.title,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(10),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              'Details',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              todo.body,
            ),
          ),
        ],
      ),
    );
  }
}
