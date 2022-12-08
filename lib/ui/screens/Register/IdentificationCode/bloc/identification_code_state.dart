part of 'identification_code_bloc.dart';

abstract class IdentificationCodeState extends Equatable {
  const IdentificationCodeState();
  @override
  List<Object?> get props => [];
}

class IdentificationCodeInitial extends IdentificationCodeState {}

class IdentificationCodeLoading extends IdentificationCodeState {}

class IdentificationCodeSuccess extends IdentificationCodeState {}

class IdentificationCodeError extends IdentificationCodeState {
  final AppException exception;

  const IdentificationCodeError(this.exception);
}
