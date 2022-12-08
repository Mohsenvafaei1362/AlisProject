part of 'products_bloc.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductAddToCartBttonLoading extends ProductsState {}

class ProductAddToCartError extends ProductsState {
  final AppException exception;

  ProductAddToCartError(this.exception);

  @override
  List<Object> get props => [exception];
}

class ProductAddToCartSuccess extends ProductsState {}

class ProductFiltterSuccess extends ProductsState {
  final List<ProductEntity> filtterProduct;

  ProductFiltterSuccess(this.filtterProduct);
}

class ProductFiltterLoading extends ProductsState {}

class ProductFiltterError extends ProductsState {
  final AppException exception;

  ProductFiltterError(this.exception);

  @override
  List<Object> get props => [exception];
}
