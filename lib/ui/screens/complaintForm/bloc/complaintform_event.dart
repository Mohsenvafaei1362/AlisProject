part of 'complaintform_bloc.dart';

abstract class ComplaintformEvent extends Equatable {
  const ComplaintformEvent();
  @override
  List<Object?> get props => [];
}

class ComplaintformStarted extends ComplaintformEvent {}

class ComplaintformClickedButton extends ComplaintformEvent {
  final String title;
  final String fullname;
  final String email;
  final int phone;
  final int codeorder;
  final String description;
  final String image;

  const ComplaintformClickedButton({
    required this.title,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.codeorder,
    required this.description,
    required this.image,
  });
}
