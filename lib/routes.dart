import 'package:djamo_todo_tdd_test/features/todos/domain/entities/todo.dart';
import 'package:djamo_todo_tdd_test/features/todos/presentation/views/todo_details_page.dart';
import 'package:djamo_todo_tdd_test/features/todos/presentation/views/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const TodoPage();
      },
    ),
    GoRoute(
      path: '/details',
      builder: (BuildContext context, GoRouterState state) {
        final todo = state.extra! as Todo;

        return TodoDetailsPage(todo);
      },
    ),
  ],
);
