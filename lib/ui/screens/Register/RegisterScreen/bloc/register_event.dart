part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object> get props => [];
}

class RegisterStarted extends RegisterEvent {}

class RegisterClickButton extends RegisterEvent {
  final int phone;
  final String phoneId;
  const RegisterClickButton({required this.phone, required this.phoneId});
}
