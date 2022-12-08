part of 'cart_bloc.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<CartResponseFake> cartResponse;
  CartSuccess(this.cartResponse);
}

class CartError extends CartState {
  final AppException exception;
  CartError(this.exception);
}

class CartAuthRequired extends CartState {}

class CartEmpty extends CartState {}
