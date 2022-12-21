part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();
  @override
  List<Object?> get props => [];
}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListSuccess extends ProductListState {
  final List<ProductEntity> products;
  final int categoryId;
  final List<String> sortNames;

  const ProductListSuccess(
    this.products,
    this.categoryId,
    this.sortNames,
  );

  @override
  List<Object?> get props => [products, categoryId, sortNames];
}

class ProductListError extends ProductListState {
  final AppException exception;
  const ProductListError(this.exception);

  @override
  List<Object?> get props => [exception];
}
