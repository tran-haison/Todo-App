import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/todo/data/models/todo_model.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const jsonFileName = 'todo.json';
  const tToDo = ToDo(id: 1, text: "todo1", isCompleted: true);
  const tToDoModel = ToDoModel(id: 1, text: "todo1", isCompleted: true);
  const Map<String, dynamic> tToDoMap = {
    "id": 1,
    "text": "todo1",
    "isCompleted": true,
  };

  test(
    "should be a subclass of ToDo entity",
    () async {
      // Check if ToDoModel is a subclass of to-do entity
      expect(tToDoModel, isA<ToDo>());
    },
  );

  test(
    'should return a valid todo model from todo entity',
    () async {
      // Get to-do model from to-do entity
      final result = ToDoModel.fromTodo(tToDo);

      // Assert
      expect(result, tToDoModel);
    },
  );

  test(
    "should return a valid todo model from json",
    () async {
      // Convert from json file to map
      final Map<String, dynamic> jsonMap = jsonDecode(fixture(jsonFileName));

      // Convert from map to model
      final result = ToDoModel.fromJson(jsonMap);

      // Check if result is a valid ToDoModel
      expect(result, tToDoModel);
    },
  );

  test(
    "should return a json map from model with valid data",
    () async {
      // Convert from model to map
      final result = tToDoModel.toJson();

      // Check if result is a valid json map with proper data
      expect(result, tToDoMap);
    },
  );
}
