part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
  @override
  List<Object?> get props => [];
}

class ChangePasswordStarted extends ChangePasswordEvent {}

class ChangePasswordClickedButton extends ChangePasswordEvent {
  final int oldpass;
  final int newpass;

  const ChangePasswordClickedButton(this.oldpass, this.newpass);
}
