part of 'confirmation_bloc.dart';

abstract class ConfirmationEvent extends Equatable {
  const ConfirmationEvent();
  @override
  List<Object> get props => [];
}

class ConfirmationStarted extends ConfirmationEvent {}

class ConfirmationClickedButton extends ConfirmationEvent {}

class ConfirmationRefresh extends ConfirmationEvent {}
