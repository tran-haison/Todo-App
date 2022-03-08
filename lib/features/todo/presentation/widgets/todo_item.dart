import 'package:flutter/material.dart';
import 'package:todo_app/config/values/dimens.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';

class TodoItem extends StatefulWidget {

  final ToDo toDo;
  final Function(ToDo) onPressed;
  final Function(ToDo) onStateChanged;

  const TodoItem({
    Key? key,
    required this.toDo,
    required this.onPressed,
    required this.onStateChanged,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius5),
        onTap: () => widget.onPressed(widget.toDo),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: dimen5,
            horizontal: dimen15,
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.toDo.text,
                    style: const TextStyle(
                      fontSize: fontSize16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: dimen10),
                Checkbox(
                  checkColor: Colors.white,
                  value: widget.toDo.isCompleted,
                  onChanged: (value) {
                    final newTodo = widget.toDo.copyWith(isCompleted: value);
                    widget.onStateChanged(newTodo);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
