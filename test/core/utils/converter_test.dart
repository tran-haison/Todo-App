import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/utils/converter.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';

void main() {
  late Converter converter;

  setUp(() {
    converter = Converter();
  });

  group(
    'textToTodoInstance',
    () {
      test(
        'should return a valid todo when text is not empty',
        () async {
          // Create new text
          const text = "todo";

          // Get result
          final result = converter.textToTodoInstance(text);

          // Assert
          expect(result, const Right(ToDo(text: text)));
        },
      );

      test(
        'should return a failure when text is empty',
        () async {
          // Create new text
          const text = "";

          // Get result
          final result = converter.textToTodoInstance(text);

          // Assert
          expect(result, Left(InputFailure()));
        },
      );
    },
  );
}
