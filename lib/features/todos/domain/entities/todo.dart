import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';

part 'todo.mapper.dart';

@MappableClass()
class Todo extends Equatable with TodoMappable {
  const Todo({
    required this.title,
    required this.body,
    this.isCompleted = false,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String title;
  final String body;
  final bool isCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<dynamic> get props => [
        id,
        title,
        body,
      ];
}
