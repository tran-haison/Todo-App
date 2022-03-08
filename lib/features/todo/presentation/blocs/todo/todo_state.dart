part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState([props]);

  @override
  List<Object?> get props => [];
}

class TodoStateEmpty extends TodoState {
  const TodoStateEmpty();
}

class TodoStateLoading extends TodoState {
  const TodoStateLoading();
}

class TodoStateDoneGetAllTodos extends TodoState {
  final List<ToDo> todoList;
  const TodoStateDoneGetAllTodos({required this.todoList}) : super(todoList);
}
class TodoStateDoneGetCompleteTodos extends TodoState {
  final List<ToDo> todoList;
  const TodoStateDoneGetCompleteTodos({required this.todoList}) : super(todoList);
}
class TodoStateDoneGetIncompleteTodos extends TodoState {
  final List<ToDo> todoList;
  const TodoStateDoneGetIncompleteTodos({required this.todoList}) : super(todoList);
}
class TodoStateDoneSaveTodo extends TodoState {
  const TodoStateDoneSaveTodo();
}

class TodoStateError extends TodoState {
  final String message;
  const TodoStateError({required this.message}) : super(message);
}