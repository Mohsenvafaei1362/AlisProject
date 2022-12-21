part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object?> get props => [];
}

class ProductListStarted extends ProductListEvent {
  final int categoryId;
  const ProductListStarted(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
