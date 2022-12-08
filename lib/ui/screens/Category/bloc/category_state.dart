part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<CategoryImageInfo> categoryImage;

  const CategorySuccess(this.categoryImage);
}

class CategoryLoading extends CategoryState {}

class CategoryError extends CategoryState {
  final AppException exception;

  const CategoryError(this.exception);
  @override
  List<Object?> get props => [exception];
}
