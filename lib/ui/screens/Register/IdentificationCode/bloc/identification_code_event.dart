part of 'identification_code_bloc.dart';

abstract class IdentificationCodeEvent extends Equatable {
  const IdentificationCodeEvent();

  @override
  List<Object?> get props => [];
}

class IdentificationCodeStarted extends IdentificationCodeEvent {}

class IdentificationCodeClickedButton extends IdentificationCodeEvent {
  final String code;

  const IdentificationCodeClickedButton(this.code);
}
