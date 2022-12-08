part of 'transaction_list_bloc.dart';

abstract class TransactionListState extends Equatable {
  const TransactionListState();
  @override
  List<Object?> get props => [];
}

class TransactionListInitial extends TransactionListState {}

class TransactionListSuccess extends TransactionListState {
  final List<TransactionListInfo> transaction;

  const TransactionListSuccess(this.transaction);
}

class TransactionListLoading extends TransactionListState {}

class TransactionListError extends TransactionListState {
  final AppException exception;

  const TransactionListError(this.exception);
  @override
  List<Object?> get props => [exception];
}
