import 'package:flutter_todo_app/bootstrap.dart';
import 'package:flutter_todo_app/l10n/l10n.dart';
import 'package:flutter_todo_app/routes.dart';
import 'package:flutter/material.dart';

void main() {
  bootstrap(() => const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
