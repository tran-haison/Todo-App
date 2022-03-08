import 'package:equatable/equatable.dart';

abstract class UseCase<T, P> {
  Future<T> call(P params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}