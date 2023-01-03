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
  final int roleRef;
  final int sellCenter;
  final int userId;
  final int usersGroupRef;
  final int visitorRef;
  const ProductListStarted({
    required this.categoryId,
    required this.modelId,
    required this.modelName,
    required this.roleRef,
    required this.sellCenter,
    required this.userId,
    required this.usersGroupRef,
    required this.visitorRef,
  });

  @override
  List<Object?> get props => [categoryId];
}


