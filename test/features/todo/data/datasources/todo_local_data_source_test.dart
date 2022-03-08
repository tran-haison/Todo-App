import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/features/todo/data/datasources/local/app_database.dart';
import 'package:todo_app/features/todo/data/datasources/local/daos/todo_dao.dart';
import 'package:todo_app/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:todo_app/features/todo/data/models/todo_model.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';

import 'todo_local_data_source_test.mocks.dart';

@GenerateMocks([AppDatabase, ToDoDao])
void main() {
  late TodoLocalDataSourceImpl todoLocalDataSource;
  late MockAppDatabase mockAppDatabase;
  late MockToDoDao mockToDoDao;

  setUp(() async {
    mockAppDatabase = MockAppDatabase();
    mockToDoDao = MockToDoDao();
    todoLocalDataSource = TodoLocalDataSourceImpl(appDatabase: mockAppDatabase);
  });

  group(
    'getAllTodos',
    () {
      final tTodoList = [
        const ToDo(id: 1, text: "todo1", isCompleted: true),
        const ToDo(id: 2, text: "todo2", isCompleted: false),
      ];

      test(
        'should get all todos from database',
        () async {
          // Stub methods
          when(mockAppDatabase.todoDao).thenReturn(mockToDoDao);
          when(mockToDoDao.getAllTodos())
              .thenAnswer((_) async => Future.value(tTodoList));

          // Get all todos from database
          final result = await todoLocalDataSource.getAllTodos();

          // Assert
          expect(result, tTodoList);
        },
      );
    },
  );

  group(
    'getConditionedTodos',
    () {
      final tCompleteTodoList = [
        const ToDoModel(id: 1, text: "todo1", isCompleted: true),
        const ToDoModel(id: 2, text: "todo2", isCompleted: true),
      ];
      final tIncompleteTodoList = [
        const ToDo(id: 1, text: "todo1", isCompleted: false),
        const ToDo(id: 2, text: "todo2", isCompleted: false),
      ];

      test(
        'should get all COMPLETE todos from database',
        () async {
          // Stub methods
          when(mockAppDatabase.todoDao).thenReturn(mockToDoDao);
          when(mockToDoDao.getConditionedTodos(true))
              .thenAnswer((_) async => Future.value(tCompleteTodoList));

          // Get all todos from database
          final result = await todoLocalDataSource.getConditionedTodos(true);

          // Assert
          expect(result, tCompleteTodoList);
          for (int i = 0; i < result.length; i++) {
            expect(result[i].isCompleted, true);
          }
        },
      );

      test(
        'should get all INCOMPLETE todos from database',
        () async {
          // Stub methods
          when(mockAppDatabase.todoDao).thenReturn(mockToDoDao);
          when(mockToDoDao.getConditionedTodos(false))
              .thenAnswer((_) async => Future.value(tIncompleteTodoList));

          // Get all todos from database
          final result = await todoLocalDataSource.getConditionedTodos(false);

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
      final tTodoList = [
        const ToDo(id: 1, text: "todo1", isCompleted: true),
        const ToDo(id: 2, text: "todo2", isCompleted: false),
      ];
      const tTodo3 = ToDo(id: 3, text: "todo3", isCompleted: true);
      const tNewTodo2 = ToDo(id: 2, text: "new todo2", isCompleted: true);

      test(
        'should save a new todo to database',
        () async {
          // Stub methods
          when(mockAppDatabase.todoDao).thenReturn(mockToDoDao);
          when(mockToDoDao.saveTodo(tTodo3)).thenAnswer((_) async {
            tTodoList.add(tTodo3);
          });

          // Act
          await todoLocalDataSource.saveTodo(tTodo3);

          // Assert
          expect(tTodoList.length, 3);
          final todo3 = tTodoList.firstWhere((item) => item.id == 3);
          expect(todo3.text, "todo3");
        },
      );

      test(
        'should update existed todo with new values to database',
        () async {
          // Stub methods
          when(mockAppDatabase.todoDao).thenReturn(mockToDoDao);
          when(mockToDoDao.saveTodo(tNewTodo2)).thenAnswer((_) async {
            final todo2 = tTodoList.firstWhere((item) => item.id == 2);
            tTodoList.remove(todo2);
            tTodoList.add(tNewTodo2);
          });

          // Act
          await todoLocalDataSource.saveTodo(tNewTodo2);

          // Assert
          final newTodo2 = tTodoList.firstWhere((item) => item.id == 2);
          expect(newTodo2.text, "new todo2");
        },
      );
    },
  );
}
