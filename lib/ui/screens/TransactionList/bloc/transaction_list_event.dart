part of 'transaction_list_bloc.dart';

abstract class TransactionListEvent extends Equatable {
  const TransactionListEvent();
  @override
  List<Object?> get props => [];
}

class TransactionListStarted extends TransactionListEvent {}

class TransactionListClickedButton extends TransactionListEvent {}
