part of 'list_tickets_bloc.dart';

abstract class ListTicketsState extends Equatable {
  const ListTicketsState();
  @override
  List<Object?> get props => [];
}

class ListTicketsInitial extends ListTicketsState {}

class ListTicketsSuccess extends ListTicketsState {
  final List<ListTicketInfo> listTicket;

  const ListTicketsSuccess({required this.listTicket});
}

class ListTicketsLoading extends ListTicketsState {}

class ListTicketsError extends ListTicketsState {
  final AppException exception;

  const ListTicketsError(this.exception);
  @override
  List<Object?> get props => [exception];
}
