import 'package:todo_app/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<ToDo>> getAllTodos();
  Future<List<ToDo>> getConditionedTodos(bool isCompleted);
  Future<void> saveTodo(ToDo toDo);
}