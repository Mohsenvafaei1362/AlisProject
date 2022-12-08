part of 'personnel_bloc.dart';

abstract class PersonnelEvent extends Equatable {
  const PersonnelEvent();
  @override
  List<Object?> get props => [];
}

class PersonnelStarted extends PersonnelEvent {}

class PersonnelClickedButton extends PersonnelEvent {
  final String fname;
  final String lname;
  final String namestore;
  final int nationalcode;
  final int phonenumber;

  const PersonnelClickedButton({
    required this.fname,
    required this.lname,
    required this.namestore,
    required this.nationalcode,
    required this.phonenumber,
  });
}
