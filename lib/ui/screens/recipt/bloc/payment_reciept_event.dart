part of 'payment_reciept_bloc.dart';

abstract class PaymentRecieptEvent extends Equatable {
  const PaymentRecieptEvent();

  @override
  List<Object?> get props => [];
}

class PaymentRecieptStarted extends PaymentRecieptEvent {
  final int orderId;
  const PaymentRecieptStarted(this.orderId);

  @override
  List<Object?> get props => [orderId];
}
