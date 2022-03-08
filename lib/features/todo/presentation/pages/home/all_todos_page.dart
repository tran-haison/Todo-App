import 'package:flutter/material.dart';
import 'package:todo_app/config/values/dimens.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/presentation/blocs/todo/todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/pages/todo_detail/todo_detail_page.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_list_view.dart';

class AllTodosPage extends StatefulWidget {
  final TodoBloc todoBloc;

  const AllTodosPage({
    Key? key,
    required this.todoBloc,
  }) : super(key: key);

  @override
  State<AllTodosPage> createState() => _AllTodosPageState();
}

class _AllTodosPageState extends State<AllTodosPage> {
  @override
  void initState() {
    super.initState();
    widget.todoBloc.notifyGetAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(dimen10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return StreamBuilder<List<ToDo>>(
      stream: widget.todoBloc.allTodosStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final todoList = snapshot.data;
          if (todoList == null || todoList.isEmpty) {
            return const Center(
              child: Text("All todos will be shown here"),
            );
          }
          return _buildTodosListView(todoList);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  Widget _buildTodosListView(List<ToDo> todoList) {
    return TodoListView(
      todoList: todoList,
      onPressed: (toDo) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => TodoDetailPage(
            toDo: toDo,
            todoBloc: widget.todoBloc,
          )),
        );
      },
      onStateChanged: (toDo) {
        widget.todoBloc.notifySaveTodo(
          toDo: toDo,
          text: toDo.text,
        );
      },
    );
  }
}
