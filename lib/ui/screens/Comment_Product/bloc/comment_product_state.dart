part of 'comment_product_bloc.dart';

abstract class CommentProductState extends Equatable {
  const CommentProductState();

  @override
  List<Object> get props => [];
}

class CommentProductInitial extends CommentProductState {}

class CommentProductSuccess extends CommentProductState {}

class CommentProductLoading extends CommentProductState {}

class CommentProductError extends CommentProductState {
  final AppException exception;

  CommentProductError(this.exception);
  @override
  List<Object> get props => [exception];
}
