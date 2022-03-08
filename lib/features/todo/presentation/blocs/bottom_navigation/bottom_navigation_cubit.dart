import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/features/todo/presentation/blocs/bottom_navigation/constants/bottom_navigation_constants.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit()
      : super(const BottomNavigationState(
          item: BottomNavigationItem.all,
          title: kBottomNavAllTodosTitle,
          index: kBottomNavAllTodosIndex,
        ));

  void getBottomNavigationItem(BottomNavigationItem item) {
    switch (item) {
      case BottomNavigationItem.all:
        emit(const BottomNavigationState(
          item: BottomNavigationItem.all,
          title: kBottomNavAllTodosTitle,
          index: kBottomNavAllTodosIndex,
        ));
        break;
      case BottomNavigationItem.complete:
        emit(const BottomNavigationState(
          item: BottomNavigationItem.complete,
          title: kBottomNavCompleteTodosTitle,
          index: kBottomNavCompleteTodosIndex,
        ));
        break;
      case BottomNavigationItem.incomplete:
        emit(const BottomNavigationState(
          item: BottomNavigationItem.incomplete,
          title: kBottomNavIncompleteTodosTitle,
          index: kBottomNavIncompleteTodosIndex,
        ));
        break;
    }
  }
}
