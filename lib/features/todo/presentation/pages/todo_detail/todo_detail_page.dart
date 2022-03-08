import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/config/values/dimens.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/presentation/blocs/todo/todo_bloc.dart';

class TodoDetailPage extends StatefulWidget {
  final ToDo? toDo;
  final TodoBloc todoBloc;

  const TodoDetailPage({
    Key? key,
    this.toDo,
    required this.todoBloc,
  }) : super(key: key);

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {

  late TextEditingController _controller;
  late bool isFirstTime;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (widget.toDo != null) {
      _controller.text = widget.toDo!.text;
    }
    isFirstTime = true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.todoBloc.saveTodoStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final isTextValid = snapshot.data;
          if (isTextValid != null) {
            if (isTextValid) {
              Navigator.of(context).pop();
            } else {
              if (isFirstTime) {
                isFirstTime = false;
              } else {
                showToast("Text must not be empty");
              }
            }
          }
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(widget.toDo != null ? "Edit todo" : "Create new todo"),
          ),
          body: _buildBody(),
        );
      }
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: dimen5,
        horizontal: dimen10,
      ),
      child: Column(
        children: <Widget>[
          Expanded(child: _buildTextFormFieldTodo()),
          const SizedBox(height: dimen10),
          Row(
            children: [
              Expanded(child: _buildElevatedButtonSave()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormFieldTodo() {
    return TextFormField(
      controller: _controller,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: fontSize18,
        fontWeight: FontWeight.w500,
      ),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: dimen10,
        ),
        hintText: "Enter todo here",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: fontSize18,
          fontWeight: FontWeight.normal,
        ),
        border: InputBorder.none,
      ),
      autocorrect: true,
      enableSuggestions: true,
    );
  }

  Widget _buildElevatedButtonSave() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: dimen10, horizontal: 0),
        textStyle: const TextStyle(
          fontSize: fontSize18,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: () {
        widget.todoBloc.notifySaveTodo(
          toDo: widget.toDo,
          text: _controller.text,
        );
      },
      child: const Text("Save"),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
