part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object?> get props => [];
}

class ProductListStarted extends ProductListEvent {
  final int categoryId;
  final int modelId;
  final String modelName;
  const ProductListStarted({
    required this.categoryId,
    required this.modelId,
    required this.modelName,
  });

  @override
  List<Object?> get props => [categoryId];
}
