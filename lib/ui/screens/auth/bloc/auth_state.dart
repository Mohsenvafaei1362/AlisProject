part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthError extends AuthState {
  // final Object err;

  // AuthError(this.err);
  final AppException appException;
  AuthError(this.appException);
}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final List<AuthInfo> authInfo;

  AuthSuccess({required this.authInfo});
}
