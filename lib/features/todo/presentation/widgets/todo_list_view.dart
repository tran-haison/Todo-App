import 'package:flutter/material.dart';
import 'package:todo_app/config/values/dimens.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_item.dart';

class TodoListView extends StatefulWidget {
  final List<ToDo> todoList;
  final Function(ToDo) onPressed;
  final Function(ToDo) onStateChanged;

  const TodoListView({
    Key? key,
    required this.todoList,
    required this.onPressed,
    required this.onStateChanged,
  }) : super(key: key);

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.todoList.length,
      itemBuilder: (_, index) {
        return TodoItem(
          toDo: widget.todoList[index],
          onPressed: widget.onPressed,
          onStateChanged: widget.onStateChanged,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: dimen10),
    );
  }
}
