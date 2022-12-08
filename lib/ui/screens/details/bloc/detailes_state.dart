part of 'detailes_bloc.dart';

abstract class DetailesState extends Equatable {
  const DetailesState();
  @override
  List<Object?> get props => [];
}

class DetailesInitial extends DetailesState {}

class DetailesSuccess extends DetailesState {
  final List<ProductEntity> detail;

  const DetailesSuccess(this.detail);
}

class DetailesLoading extends DetailesState {}

class DetailesError extends DetailesState {
  final AppException exception;

  const DetailesError(this.exception);
  @override
  List<Object?> get props => [exception];
}
