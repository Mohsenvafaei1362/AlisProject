part of 'new_ticket_bloc.dart';

abstract class NewTicketEvent extends Equatable {
  const NewTicketEvent();
  @override
  List<Object?> get props => [];
}

class NewTicketStarted extends NewTicketEvent {}

class NewTicketClickedButtonSendData extends NewTicketEvent {}

class NewTicketClickedButtonUploadDocument extends NewTicketEvent {}

class NewTicketClickedButtonChat extends NewTicketEvent {}
