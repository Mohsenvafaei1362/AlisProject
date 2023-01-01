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
  final int count;

  const ProductAddToCartButtonClicked(this.productId, this.count);
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
  final String sourceTitle;
  final String model;
  final int userId;
  final int sellsCenter;
  final int categoryId;
  final String event;
  final int modelId;

  const ProductSendLog({
    required this.productId,
    required this.sourceTitle,
    required this.model,
    required this.userId,
    required this.sellsCenter,
    required this.categoryId,
    required this.event,
    required this.modelId,
  });
}
