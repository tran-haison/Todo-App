import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/todo/domain/usecases/get_complete_todos.dart';

import 'get_complete_todos_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late GetCompleteTodos useCase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    useCase = GetCompleteTodos(mockTodoRepository);
  });

  final List<ToDo> tCompleteTodoList = [
    const ToDo(id: 1, text: "todo1", isCompleted: true),
    const ToDo(id: 2, text: "todo2", isCompleted: true),
  ];

  test(
    "should get all complete todos from repository",
    () async {
      // Stub "getConditionedTodos" method
      when(mockTodoRepository.getConditionedTodos(true))
          .thenAnswer((_) async => Future.value(tCompleteTodoList));

      // Get all complete todos use case
      final completedTodos = await useCase(NoParams());

      // Check length of list after getting all complete todos
      expect(completedTodos.length, 2);
      // Check every items in list should be completed
      for (int i = 0; i < completedTodos.length; i++) {
        expect(completedTodos[i].isCompleted, true);
      }
    },
  );
}
