part of 'confirmation_bloc.dart';

abstract class ConfirmationState {}

class ConfirmationInitial extends ConfirmationState {}

class ConfirmationSuccess extends ConfirmationState {
  final String getState;
  ConfirmationSuccess({required this.getState});
}

class ConfirmationError extends ConfirmationState {
  final AppException exception;
  ConfirmationError(this.exception);
}

class ConfirmationLoading extends ConfirmationState {}
