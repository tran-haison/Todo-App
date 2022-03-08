import 'package:floor/floor.dart';
import 'package:todo_app/core/utils/constants.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';

@dao
abstract class ToDoDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveTodo(ToDo toDo);

  @Query('SELECT * FROM $kTodoTableName')
  Future<List<ToDo>> getAllTodos();

  @Query('SELECT * FROM $kTodoTableName WHERE isCompleted = :isCompleted')
  Future<List<ToDo>> getConditionedTodos(bool isCompleted);
}
