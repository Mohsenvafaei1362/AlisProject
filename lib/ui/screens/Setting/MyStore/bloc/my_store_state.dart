part of 'my_store_bloc.dart';

abstract class MyStoreState extends Equatable {
  const MyStoreState();
  @override
  List<Object?> get props => [];
}

class MyStoreInitial extends MyStoreState {}

class MyStoreSuccess extends MyStoreState {
  final List<MyStoreInfo> mystore;

  const MyStoreSuccess(this.mystore);
}

class MyStoreLoading extends MyStoreState {}

class MyStoreError extends MyStoreState {
  final AppException exception;

  const MyStoreError(this.exception);
  @override
  List<Object?> get props => [exception];
}
