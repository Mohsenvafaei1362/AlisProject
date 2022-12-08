part of 'bank_account_bloc.dart';

abstract class BankAccountEvent extends Equatable {
  const BankAccountEvent();
  @override
  List<Object?> get props => [];
}

class BankAccountStarted extends BankAccountEvent {}

class BankAccountClickedButton extends BankAccountEvent {
  final String nameBank;
  final String cardHolderName;
  final String cardnumber;
  final String expiryDate;
  final String cvvCode;

  const BankAccountClickedButton(
    this.nameBank,
    this.cardHolderName,
    this.cardnumber,
    this.expiryDate,
    this.cvvCode,
  );
}
