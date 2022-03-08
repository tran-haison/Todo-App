import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';

class SaveTodo implements UseCase<void, ToDo> {
  final TodoRepository todoRepository;

  const SaveTodo(this.todoRepository);

  @override
  Future<void> call(ToDo toDo) async {
    return await todoRepository.saveTodo(toDo);
  }
}
