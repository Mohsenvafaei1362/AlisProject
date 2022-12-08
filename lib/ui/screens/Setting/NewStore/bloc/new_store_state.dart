part of 'new_store_bloc.dart';

abstract class NewStoreState extends Equatable {
  const NewStoreState();
  @override
  List<Object?> get props => [];
}

class NewStoreInitial extends NewStoreState {}

class NewStoreSuccess extends NewStoreState {}

class NewStoreLoading extends NewStoreState {}

class NewStoreError extends NewStoreState {
  final AppException exception;

  const NewStoreError(this.exception);
  @override
  List<Object?> get props => [exception];
}
