import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';

class Converter {
  Either<Failure, ToDo> textToTodoInstance(String text) {
    if (text.isEmpty) {
      return Left(InputFailure());
    } else {
      return Right(ToDo(text: text));
    }
  }
}



