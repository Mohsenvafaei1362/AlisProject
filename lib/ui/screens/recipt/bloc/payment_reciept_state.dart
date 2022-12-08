part of 'payment_reciept_bloc.dart';

abstract class PaymentRecieptState extends Equatable {
  const PaymentRecieptState();

  @override
  List<Object?> get props => [];
}

class PaymentRecieptInitial extends PaymentRecieptState {}

class PaymentRecieptSuccess extends PaymentRecieptState {
  final PaymentRecieptData paymentRecieptData;
  const PaymentRecieptSuccess(this.paymentRecieptData);

  @override
  List<Object?> get props => [paymentRecieptData];
}

class PaymentRecieptError extends PaymentRecieptState {
  final AppException exception;
  const PaymentRecieptError(this.exception);
  @override
  List<Object?> get props => [exception];
}

class PaymentRecieptLoading extends PaymentRecieptState {}
