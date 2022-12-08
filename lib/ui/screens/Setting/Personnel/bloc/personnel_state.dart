part of 'personnel_bloc.dart';

abstract class PersonnelState extends Equatable {
  const PersonnelState();
  @override
  List<Object?> get props => [];
}

class PersonnelInitial extends PersonnelState {}

class PersonnelSuccessgetPersonnel extends PersonnelState {}

class PersonnelSuccessSendPersonnel extends PersonnelState {}

class PersonnelLoading extends PersonnelState {}

class PersonnelErrorgetPersonnel extends PersonnelState {
  final AppException exception;

  const PersonnelErrorgetPersonnel(this.exception);
  @override
  List<Object?> get props => [exception];
}

class PersonnelErrorSendPersonnel extends PersonnelState {
  final AppException exception;

  const PersonnelErrorSendPersonnel(this.exception);
  @override
  List<Object?> get props => [exception];
}
