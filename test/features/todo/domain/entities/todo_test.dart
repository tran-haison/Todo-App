import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';

void main() {
  const tTodo1 = ToDo(id: 1, text: "todo1", isCompleted: true);

  group(
    'copyWith',
    () {
      test('should return a SIMILAR todo when NOT input parameters', () {
        // Get result
        final result = tTodo1.copyWith();

        // Assert
        expect(result, tTodo1);
      });

      test('should return a SIMILAR todo when input SAME parameters', () {
        // Get result
        final result = tTodo1.copyWith(id: 1, text: "todo1", isCompleted: true);

        // Assert
        expect(result, tTodo1);
      });

      test('should return a DIFFERENT todo when input DIFFERENT parameters', () {
        // Get result
        final result = tTodo1.copyWith(id: 2, text: "todo2", isCompleted: false);

        // Assert
        expect(result, isNot(tTodo1));
      });
    },
  );
}
