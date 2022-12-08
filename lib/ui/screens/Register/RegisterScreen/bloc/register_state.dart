part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

// class RegisterStarted extends RegisterState {}

class RegisterError extends RegisterState {
  final AppException exception;
  RegisterError(this.exception);
}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}
