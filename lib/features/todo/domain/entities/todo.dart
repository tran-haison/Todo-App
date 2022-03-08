import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:todo_app/core/utils/constants.dart';

@Entity(tableName: kTodoTableName)
class ToDo extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String text;
  final bool isCompleted;

  const ToDo({
    this.id,
    required this.text,
    this.isCompleted = false,
  });

  ToDo copyWith({
    int? id,
    String? text,
    bool? isCompleted,
  }) {
    return ToDo(
      id: id ?? this.id,
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, text, isCompleted];
}
