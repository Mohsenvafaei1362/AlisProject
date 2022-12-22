part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
  @override
  List<Object?> get props => [];
}

class ProductStarted extends ProductsEvent {
  final String sort;

  const ProductStarted(this.sort);
}

class ProductAddToCartButtonClicked extends ProductsEvent {
  final int productId;

  const ProductAddToCartButtonClicked(this.productId);
}

class ProductAddToFavoriteButtonClicked extends ProductsEvent {
  final int productId;

  const ProductAddToFavoriteButtonClicked(this.productId);
}

class ProductFiltterBttonClicked extends ProductsEvent {
  final int sort;

  const ProductFiltterBttonClicked(this.sort);
}

class ProductSendLog extends ProductsEvent {
  final int productId;
  final String title;
  final String message;

  const ProductSendLog(
    this.productId,
    this.title,
    this.message,
  );
}
