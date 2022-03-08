import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';

class GetIncompleteTodos implements UseCase<List<ToDo>, NoParams> {
  final TodoRepository todoRepository;

  const GetIncompleteTodos(this.todoRepository);

  @override
  Future<List<ToDo>> call(NoParams params) async {
    return await todoRepository.getConditionedTodos(false);
  }
}