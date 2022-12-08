part of 'add_point_screen_bloc.dart';

abstract class AddPointScreenState extends Equatable {
  const AddPointScreenState();
  @override
  List<Object?> get props => [];
}

class AddPointScreenInitial extends AddPointScreenState {}

// class AddPointScreenStarted extends AddPointScreenState {}

class AddPointScreenLoading extends AddPointScreenState {}

class AddPointScreenError extends AddPointScreenState {
  final AppException exception;

  const AddPointScreenError(this.exception);

  @override
  List<Object?> get props => [exception];
}

class AddPointScreenSuccess extends AddPointScreenState {}
