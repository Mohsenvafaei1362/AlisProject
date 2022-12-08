part of 'new_ticket_bloc.dart';

abstract class NewTicketState extends Equatable {
  const NewTicketState();
  @override
  List<Object?> get props => [];
}

class NewTicketInitial extends NewTicketState {}

class NewTicketSuccess extends NewTicketState {
  final List<NewTicketInfo> ticket;

  const NewTicketSuccess({required this.ticket});
}

class NewTicketLoading extends NewTicketState {}

class NewTicketError extends NewTicketState {
  final AppException exception;

  const NewTicketError(this.exception);
  @override
  List<Object?> get props => [exception];
}
