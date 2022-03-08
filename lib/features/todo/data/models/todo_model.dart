import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class ToDoModel extends ToDo {

  final int id;
  final String text;
  final bool isCompleted;

  const ToDoModel({
    required this.id,
    required this.text,
    required this.isCompleted,
  }) : super(id: id, text: text, isCompleted: isCompleted);

  static ToDoModel fromTodo(ToDo toDo) {
    return ToDoModel(
      id: toDo.id ?? 0,
      text: toDo.text,
      isCompleted: toDo.isCompleted,
    );
  }

  factory ToDoModel.fromJson(Map<String, dynamic> json) =>
      _$ToDoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoModelToJson(this);
}
