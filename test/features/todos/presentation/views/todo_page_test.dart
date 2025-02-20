import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_todo_app/features/todos/presentation/bloc/todo_bloc.dart';
import 'package:flutter_todo_app/features/todos/presentation/views/todo_page.dart';
import 'package:flutter_todo_app/locator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/pump_app.dart';

class MockTodoBloc extends MockBloc<TodoEvent, TodoState> implements TodoBloc {}

void main() {
  group('TodoPage', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      WidgetsFlutterBinding.ensureInitialized();

      await setupLocator(testMode: true);
    });

    testWidgets('renders TodoView', (tester) async {
      await tester.pumpApp(const TodoPage());
      expect(find.byType(TodoView), findsOneWidget);
    });
  });
}
