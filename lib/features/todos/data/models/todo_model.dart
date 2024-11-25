import 'package:djamo_todo_tdd_test/features/todos/domain/entities/todo.dart';
import 'package:isar/isar.dart';

part 'todo_model.g.dart';

@collection
class TodoModel {
  TodoModel({
    this.body,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.isCompleted = false,
  });

  Id? id = Isar.autoIncrement;
  String? title;
  String? body;

  bool isCompleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  @ignore
  Todo get toEntity => Todo(
        id: id,
        body: body!,
        title: title!,
        isCompleted: isCompleted,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
