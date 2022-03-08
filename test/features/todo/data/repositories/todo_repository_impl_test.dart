import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:todo_app/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';

import 'todo_repository_impl_test.mocks.dart';

@GenerateMocks([TodoLocalDataSource])
void main() {
  late TodoRepositoryImpl todoRepositoryImpl;
  late MockTodoLocalDataSource mockTodoLocalDataSource;

  setUp(() {
    mockTodoLocalDataSource = MockTodoLocalDataSource();
    todoRepositoryImpl = TodoRepositoryImpl(
      todoLocalDataSource: mockTodoLocalDataSource,
    );
  });

  group(
    'getAllTodos',
    () {
      // Init test variables
      final tToDoList = [
        const ToDo(id: 1, text: "todo1", isCompleted: true),
        const ToDo(id: 2, text: "todo2", isCompleted: false),
      ];

      test(
        'should get all todos from local data source',
        () async {
          // Stub method
          when(mockTodoLocalDataSource.getAllTodos())
              .thenAnswer((_) async => Future.value(tToDoList));

          // Get result
          final result = await todoRepositoryImpl.getAllTodos();

          // Assert
          expect(result, tToDoList);
        },
      );
    },
  );

  group(
    'getConditionedTodos',
    () {
      // Init test variables
      final tCompleteTodoList = [
        const ToDo(id: 1, text: "todo1", isCompleted: true),
        const ToDo(id: 2, text: "todo2", isCompleted: true),
      ];
      final tIncompleteTodoList = [
        const ToDo(id: 1, text: "todo1", isCompleted: false),
        const ToDo(id: 2, text: "todo2", isCompleted: false),
      ];

      test(
        'should get all COMPLETE todos from local data source',
        () async {
          // Stub method
          when(mockTodoLocalDataSource.getConditionedTodos(true))
              .thenAnswer((_) async => Future.value(tCompleteTodoList));

          // Get result
          final result = await todoRepositoryImpl.getConditionedTodos(true);

          // Assert
          expect(result, tCompleteTodoList);
          for (int i = 0; i < result.length; i++) {
            expect(result[i].isCompleted, true);
          }
        },
      );

      test(
        'should get all INCOMPLETE todos from local data source',
            () async {
          // Stub method
          when(mockTodoLocalDataSource.getConditionedTodos(false))
              .thenAnswer((_) async => Future.value(tIncompleteTodoList));

          // Get result
          final result = await todoRepositoryImpl.getConditionedTodos(false);

          // Assert
          expect(result, tIncompleteTodoList);
          for (int i = 0; i < result.length; i++) {
            expect(result[i].isCompleted, false);
          }
        },
      );
    },
  );

  group(
    'saveTodo',
    () {
      // Init test variables
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

      test(
        "should save a new todo to local data source",
        () async {
          // Stub "saveTodo" method
          when(mockTodoLocalDataSource.saveTodo(tToDo3)).thenAnswer(
            (_) async {
              tTodoList1.add(tToDo3);
              Future.value(tTodoList1);
            },
          );

          // Save new to-do
          await todoRepositoryImpl.saveTodo(tToDo3);

          // Check length of list after adding new todo3
          expect(tTodoList1.length, 3);
          // Check value of todo3
          final todo3 = tTodoList1.firstWhere((item) => item.id == 3);
          expect(todo3.text, "todo3");
        },
      );

      test(
        "should update existed todo with new values to local data source",
        () async {
          // Stub "saveTodo" method
          when(mockTodoLocalDataSource.saveTodo(tNewToDo2)).thenAnswer(
            (_) async {
              final todo2 = tTodoList2.firstWhere((item) => item.id == 2);
              tTodoList2.remove(todo2);
              tTodoList2.add(tNewToDo2);
              Future.value(tTodoList2);
            },
          );

          // Update todo2 with new value
          await todoRepositoryImpl.saveTodo(tNewToDo2);

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
