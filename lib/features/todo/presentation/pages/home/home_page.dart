import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/presentation/blocs/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:todo_app/features/todo/presentation/blocs/bottom_navigation/constants/bottom_navigation_constants.dart';
import 'package:todo_app/features/todo/presentation/blocs/todo/todo_bloc.dart';
import 'package:todo_app/features/todo/presentation/pages/home/all_todos_page.dart';
import 'package:todo_app/features/todo/presentation/pages/home/complete_todos_page.dart';
import 'package:todo_app/features/todo/presentation/pages/home/incomplete_todos_page.dart';
import 'package:todo_app/features/todo/presentation/pages/todo_detail/todo_detail_page.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late TodoBloc todoBloc;

  @override
  void initState() {
    super.initState();
    todoBloc = BlocProvider.of<TodoBloc>(context);
  }

  @override
  void dispose() {
    todoBloc.dispose();
    todoBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (bottomNavContext, bottomNavState) {
        return Scaffold(
          appBar: AppBar(title: Text(bottomNavState.title)),
          body: _buildBody(bottomNavState),
          bottomNavigationBar: _buildBottomNavigationBar(
            bottomNavContext,
            bottomNavState,
          ),
          floatingActionButton: _buildFloatingActionButton(context),
        );
      },
    );
  }

  Widget _buildBody(BottomNavigationState state) {
    switch (state.item) {
      case BottomNavigationItem.all:
        return AllTodosPage(todoBloc: todoBloc);
      case BottomNavigationItem.complete:
        return CompleteTodosPage(todoBloc: todoBloc);
      case BottomNavigationItem.incomplete:
        return IncompleteTodosPage(todoBloc: todoBloc);
    }
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
    BottomNavigationState state,
  ) {
    final bottomNavCubit = BlocProvider.of<BottomNavigationCubit>(context);
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      currentIndex: state.index,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_rounded),
          label: kBottomNavAllTodosTitle,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.thumb_up_alt_outlined),
          label: kBottomNavCompleteTodosTitle,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.thumb_down_alt_outlined),
          label: kBottomNavIncompleteTodosTitle,
        ),
      ],
      onTap: (index) {
        switch (index) {
          case kBottomNavAllTodosIndex:
            bottomNavCubit.getBottomNavigationItem(BottomNavigationItem.all);
            break;
          case kBottomNavCompleteTodosIndex:
            bottomNavCubit.getBottomNavigationItem(BottomNavigationItem.complete);
            break;
          case kBottomNavIncompleteTodosIndex:
            bottomNavCubit.getBottomNavigationItem(BottomNavigationItem.incomplete);
            break;
        }
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => TodoDetailPage(todoBloc: todoBloc)),
        );
      },
    );
  }
}
