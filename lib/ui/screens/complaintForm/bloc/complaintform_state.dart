part of 'complaintform_bloc.dart';

abstract class ComplaintformState extends Equatable {
  const ComplaintformState();
  @override
  List<Object?> get props => [];
}

class ComplaintformInitial extends ComplaintformState {}

class ComplaintformSuccess extends ComplaintformState {}

class ComplaintformLoading extends ComplaintformState {}

class ComplaintformError extends ComplaintformState {
  final AppException exception;

  const ComplaintformError(this.exception);
  @override
  List<Object?> get props => [exception];
}
