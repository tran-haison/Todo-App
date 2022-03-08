import 'dart:async';

import 'package:floor/floor.dart';
import 'package:todo_app/features/todo/data/datasources/local/daos/todo_dao.dart';
import 'package:todo_app/features/todo/data/models/todo_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:todo_app/features/todo/domain/entities/todo.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [ToDo])
abstract class AppDatabase extends FloorDatabase {
  ToDoDao get todoDao;
}