part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthButtonLoginIsClicked extends AuthEvent {
  final String username;
  final String password;

  const AuthButtonLoginIsClicked(this.username, this.password);
}

class AuthButtonRegisterIsClicked extends AuthEvent {
  final String phonenumber;
  final String phoneId;
  const AuthButtonRegisterIsClicked(this.phonenumber, this.phoneId);
}
