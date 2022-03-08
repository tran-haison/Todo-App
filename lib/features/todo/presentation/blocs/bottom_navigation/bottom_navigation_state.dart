part of 'bottom_navigation_cubit.dart';

class BottomNavigationState extends Equatable {
  final BottomNavigationItem item;
  final String title;
  final int index;

  const BottomNavigationState({
    required this.item,
    required this.title,
    required this.index,
  });

  @override
  List<Object?> get props => [item, title, index];
}
