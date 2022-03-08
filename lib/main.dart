import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/utils/constants.dart';
import 'package:todo_app/injector.dart';

import 'features/todo/presentation/blocs/bottom_navigation/bottom_navigation_cubit.dart';
import 'features/todo/presentation/blocs/todo/todo_bloc.dart';
import 'features/todo/presentation/pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<BottomNavigationCubit>()),
        BlocProvider(create: (_) => getIt<TodoBloc>()),
      ],
      child: MaterialApp(
        title: kAppTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
