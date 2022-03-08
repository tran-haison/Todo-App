import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/todo/domain/usecases/get_incomplete_todos.dart';

import 'get_incomplete_todos_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late GetIncompleteTodos useCase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    useCase = GetIncompleteTodos(mockTodoRepository);
  });

  final List<ToDo> tIncompleteTodoList = [
    const ToDo(id: 1, text: "todo1", isCompleted: false),
    const ToDo(id: 2, text: "todo2", isCompleted: false),
  ];

  test(
    "should get all incomplete todos from repository",
    () async {
      // Stub "getConditionedTodos" method
      when(mockTodoRepository.getConditionedTodos(false))
          .thenAnswer((_) async => Future.value(tIncompleteTodoList));

      // Get all incomplete todos use case
      final incompleteTodos = await useCase(NoParams());

      // Check length of list after getting all incomplete todos
      expect(incompleteTodos.length, 2);
      // Check every items in list should be incomplete
      for (int i = 0; i < incompleteTodos.length; i++) {
        expect(incompleteTodos[i].isCompleted, false);
      }
    },
  );
}
