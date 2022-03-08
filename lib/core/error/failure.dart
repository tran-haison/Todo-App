import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object?> get props => [];
}

// Database failure
class DatabaseFailure extends Failure {}

// Converter failure
class ConverterFailure extends Failure {}
class InputFailure extends ConverterFailure {}