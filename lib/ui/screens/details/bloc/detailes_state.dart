part of 'detailes_bloc.dart';

abstract class DetailesState extends Equatable {
  const DetailesState();
  @override
  List<Object?> get props => [];
}

class DetailesInitial extends DetailesState {}

class DetailesSuccess extends DetailesState {
  final List<PromotionEntity> similar;
  final List<PropertyEntity> property;
  final List<CommentProduct> comment;
  final List<ProductEntity> productDetail;
  final List<ProductEntity> productCount;

  const DetailesSuccess(
    this.similar,
    this.comment,
    this.property,
    this.productDetail,
    this.productCount,
  );
}

class DetailesClickedSuccess extends DetailesState {}

class DetailesLoading extends DetailesState {}

class DetailesError extends DetailesState {
  final AppException exception;

  const DetailesError(this.exception);
  @override
  List<Object?> get props => [exception];
}
