part of 'list_tickets_bloc.dart';

abstract class ListTicketsEvent extends Equatable {
  const ListTicketsEvent();
  @override
  List<Object?> get props => [];
}

class ListTicketsStarted extends ListTicketsEvent {}

class ListTicketsClickedButton extends ListTicketsEvent {}
