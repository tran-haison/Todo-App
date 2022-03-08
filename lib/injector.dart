import 'package:get_it/get_it.dart';
import 'package:todo_app/core/utils/constants.dart';
import 'package:todo_app/core/utils/converter.dart';
import 'package:todo_app/features/todo/data/datasources/local/app_database.dart';
import 'package:todo_app/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:todo_app/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/todo/domain/usecases/get_all_todos.dart';
import 'package:todo_app/features/todo/domain/usecases/get_complete_todos.dart';
import 'package:todo_app/features/todo/domain/usecases/get_incomplete_todos.dart';
import 'package:todo_app/features/todo/domain/usecases/save_todo.dart';
import 'package:todo_app/features/todo/presentation/blocs/todo/todo_bloc.dart';

import 'features/todo/presentation/blocs/bottom_navigation/bottom_navigation_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupInjector() async {
  // Database
  final appDatabase =
      await $FloorAppDatabase.databaseBuilder(kDatabaseName).build();
  getIt.registerLazySingleton<AppDatabase>(() => appDatabase);

  // Data source
  getIt.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(appDatabase: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(todoLocalDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetAllTodos(getIt()));
  getIt.registerLazySingleton(() => GetCompleteTodos(getIt()));
  getIt.registerLazySingleton(() => GetIncompleteTodos(getIt()));
  getIt.registerLazySingleton(() => SaveTodo(getIt()));

  // Bloc
  getIt.registerFactory(
    () => TodoBloc(
      getAllTodos: getIt(),
      getCompleteTodos: getIt(),
      getIncompleteTodos: getIt(),
      saveTodo: getIt(),
      converter: getIt(),
    ),
  );
  getIt.registerFactory(() => BottomNavigationCubit());

  // Core
  getIt.registerLazySingleton(() => Converter());
}
