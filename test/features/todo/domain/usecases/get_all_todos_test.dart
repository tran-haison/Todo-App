import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/todo/domain/usecases/get_all_todos.dart';

import 'get_all_todos_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late GetAllTodos useCase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    useCase = GetAllTodos(mockTodoRepository);
  });

  final List<ToDo> tTodoList = [
    const ToDo(id: 1, text: "todo1", isCompleted: true),
    const ToDo(id: 2, text: "todo2", isCompleted: false),
  ];

  test(
    "should get all todos from repository",
    () async {
      // Stub "getAllTodos" method
      when(mockTodoRepository.getAllTodos()).thenAnswer((_) async => Future.value(tTodoList));

      // Get all todos use case
      final todos = await useCase(NoParams());

      // Check length of list after getting all todos
      expect(todos.length, 2);
    },
  );
}
