part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
  @override
  List<Object?> get props => [];
}

class WalletStarted extends WalletEvent {}

class WalletClickedButtonCharge extends WalletEvent {
  final String price, cardNumber, ccv, years, month, pass;
  final bool saveCard;

  const WalletClickedButtonCharge({
    required this.price,
    required this.cardNumber,
    required this.ccv,
    required this.years,
    required this.month,
    required this.pass,
    required this.saveCard,
  });
}

class WalletClickedButtonDecharge extends WalletEvent {
  final String price;

  const WalletClickedButtonDecharge(this.price);
}
