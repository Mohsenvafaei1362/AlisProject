part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState();
  @override
  List<Object?> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordError extends ChangePasswordState {
  final AppException exception;

  const ChangePasswordError(this.exception);
  @override
  List<Object?> get props => [exception];
}
