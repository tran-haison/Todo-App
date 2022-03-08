import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/todo/domain/usecases/save_todo.dart';

import 'save_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late SaveTodo useCase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    useCase = SaveTodo(mockTodoRepository);
  });

  final List<ToDo> tTodoList1 = [
    const ToDo(id: 1, text: "todo1", isCompleted: true),
    const ToDo(id: 2, text: "todo2", isCompleted: false),
  ];
  final List<ToDo> tTodoList2 = [
    const ToDo(id: 1, text: "todo1", isCompleted: true),
    const ToDo(id: 2, text: "todo2", isCompleted: false),
  ];
  const ToDo tNewToDo2 = ToDo(id: 2, text: "new todo2", isCompleted: true);
  const ToDo tToDo3 = ToDo(id: 3, text: "todo3", isCompleted: false);

  group(
    "save todo to repository",
    () {
      test(
        "should save a new todo",
        () async {
          // Stub "saveTodo" method
          when(mockTodoRepository.saveTodo(tToDo3)).thenAnswer(
            (_) async {
              tTodoList1.add(tToDo3);
              return Future.value(tTodoList1);
            },
          );

          // Save new to-do
          await useCase(tToDo3);

          // Check length of list after adding new todo3
          expect(tTodoList1.length, 3);
          // Check value of todo3
          final todo3 = tTodoList1.firstWhere((item) => item.id == 3);
          expect(todo3.text, "todo3");
        },
      );

      test(
        "should update existed todo with new values",
        () async {
          // Stub "saveTodo" method
          when(mockTodoRepository.saveTodo(tNewToDo2)).thenAnswer(
            (_) async {
              final todo2 = tTodoList2.firstWhere((item) => item.id == 2);
              tTodoList2.remove(todo2);
              tTodoList2.add(tNewToDo2);
              return Future.value(tTodoList2);
            },
          );

          // Update todo2 with new value
          await useCase(tNewToDo2);

          // Check length of list after updating todo2
          expect(tTodoList2.length, 2);
          // Check new value of todo2
          final newTodo2 = tTodoList2.firstWhere((item) => item.id == 2);
          expect(newTodo2.text, "new todo2");
        },
      );
    },
  );
}
