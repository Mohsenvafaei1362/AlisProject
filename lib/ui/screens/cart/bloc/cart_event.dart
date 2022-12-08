part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartAdddButton extends CartEvent {
  final int productId;
  CartAdddButton(this.productId);
}

class CartDeleteButtonClicked extends CartEvent {
  final int cartItemId;
  CartDeleteButtonClicked(this.cartItemId);
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;
  final bool isRefreshing;

  CartStarted(this.authInfo, {this.isRefreshing = false});
}

class CartAuthInfoChanged extends CartEvent {
  final AuthInfo? authInfo;

  CartAuthInfoChanged(this.authInfo);
}

class IncreaseCountButtonClicked extends CartEvent {
  final int cartItemId;

  IncreaseCountButtonClicked(this.cartItemId);
  @override
  List<Object?> get props => [cartItemId];
}

class DecreaseCountButtonClicked extends CartEvent {
  final int cartItemId;

  DecreaseCountButtonClicked(this.cartItemId);
  @override
  List<Object?> get props => [cartItemId];
}
