import 'package:todo_app/features/todo/data/datasources/local/app_database.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';

abstract class TodoLocalDataSource {
  Future<List<ToDo>> getAllTodos();
  Future<List<ToDo>> getConditionedTodos(bool isCompleted);
  Future<void> saveTodo(ToDo toDo);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final AppDatabase appDatabase;

  const TodoLocalDataSourceImpl({required this.appDatabase});

  @override
  Future<List<ToDo>> getAllTodos() async {
    return await appDatabase.todoDao.getAllTodos();
  }

  @override
  Future<List<ToDo>> getConditionedTodos(bool isCompleted) async {
    return await appDatabase.todoDao.getConditionedTodos(isCompleted);
  }

  @override
  Future<void> saveTodo(ToDo toDo) async {
    return await appDatabase.todoDao.saveTodo(toDo);
  }
}
