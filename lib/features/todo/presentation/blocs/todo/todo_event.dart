part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent([props]);

  @override
  List<Object?> get props => [];
}

class GetAllTodosEvent extends TodoEvent {
  const GetAllTodosEvent();
}

class GetCompleteTodosEvent extends TodoEvent {
  const GetCompleteTodosEvent();
}

class GetIncompleteTodosEvent extends TodoEvent {
  const GetIncompleteTodosEvent();
}

class SaveTodoEvent extends TodoEvent {
  final String text;
  const SaveTodoEvent({required this.text}) : super(text);
}
