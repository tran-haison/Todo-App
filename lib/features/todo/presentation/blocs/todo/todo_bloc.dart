import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/core/utils/converter.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/usecases/get_all_todos.dart';
import 'package:todo_app/features/todo/domain/usecases/get_complete_todos.dart';
import 'package:todo_app/features/todo/domain/usecases/get_incomplete_todos.dart';
import 'package:todo_app/features/todo/domain/usecases/save_todo.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodos getAllTodos;
  final GetCompleteTodos getCompleteTodos;
  final GetIncompleteTodos getIncompleteTodos;
  final SaveTodo saveTodo;
  final Converter converter;

  TodoBloc({
    required this.getAllTodos,
    required this.getCompleteTodos,
    required this.getIncompleteTodos,
    required this.saveTodo,
    required this.converter,
  }) : super(const TodoStateEmpty());

  final _allTodosController = BehaviorSubject<List<ToDo>>();
  final _completeTodosController = BehaviorSubject<List<ToDo>>();
  final _incompleteTodosController = BehaviorSubject<List<ToDo>>();
  BehaviorSubject<bool> _saveTodoController = BehaviorSubject<bool>();

  Stream<List<ToDo>> get allTodosStream => _allTodosController.stream;
  Stream<List<ToDo>> get completeTodosStream => _completeTodosController.stream;
  Stream<List<ToDo>> get incompleteTodosStream => _incompleteTodosController.stream;
  Stream<bool> get saveTodoStream => _saveTodoController.stream;

  Function(List<ToDo>) get _setAllTodosStream => _allTodosController.sink.add;
  Function(List<ToDo>) get _setCompleteTodosStream => _completeTodosController.sink.add;
  Function(List<ToDo>) get _setIncompleteTodosStream => _incompleteTodosController.sink.add;
  Function(bool) get _setSaveTodoStream => _saveTodoController.sink.add;

  Future<void> notifyGetAllTodos() async {
    final result = await getAllTodos(NoParams());
    _setAllTodosStream(result);
  }

  Future<void> notifyGetCompleteTodos() async {
    final result = await getCompleteTodos(NoParams());
    _setCompleteTodosStream(result);
  }

  Future<void> notifyGetIncompleteTodos() async {
    final result = await getIncompleteTodos(NoParams());
    _setIncompleteTodosStream(result);
  }

  Future<void> notifySaveTodo({
    ToDo? toDo,
    required String text,
  }) async {
    final inputEither = converter.textToTodoInstance(text);
    await inputEither.fold(
      (failure) {
        _setSaveTodoStream(false);
      },
      (newTodo) async {
        if (toDo != null) {
          final updatedTodo = toDo.copyWith(text: text);
          await saveTodo(updatedTodo);
        } else {
          await saveTodo(newTodo);
        }
        notifyGetAllTodos();
        notifyGetCompleteTodos();
        notifyGetIncompleteTodos();
        _setSaveTodoStream(true);
        _saveTodoController = BehaviorSubject();
      },
    );
  }

  void dispose() {
    _allTodosController.close();
    _completeTodosController.close();
    _incompleteTodosController.close();
    _saveTodoController.close();
  }
}
