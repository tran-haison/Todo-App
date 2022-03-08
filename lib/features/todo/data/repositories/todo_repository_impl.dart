import 'package:todo_app/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource todoLocalDataSource;

  const TodoRepositoryImpl({
    required this.todoLocalDataSource,
  });

  @override
  Future<List<ToDo>> getAllTodos() async {
    return await todoLocalDataSource.getAllTodos();
  }

  @override
  Future<List<ToDo>> getConditionedTodos(bool isCompleted) async {
    return await todoLocalDataSource.getConditionedTodos(isCompleted);
  }

  @override
  Future<void> saveTodo(ToDo toDo) async {
    return await todoLocalDataSource.saveTodo(toDo);
  }
}
