part of 'bank_account_bloc.dart';

abstract class BankAccountState extends Equatable {
  const BankAccountState();
  @override
  List<Object?> get props => [];
}

class BankAccountInitial extends BankAccountState {}

class BankAccountSuccess extends BankAccountState {
  final List<BankAccountInfo> bankAccount;

  const BankAccountSuccess(this.bankAccount);
}

class BankAccountLoading extends BankAccountState {}

class BankAccountError extends BankAccountState {
  final AppException exception;

  const BankAccountError(this.exception);
  @override
  List<Object?> get props => [exception];
}
