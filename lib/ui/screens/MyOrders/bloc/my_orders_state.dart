part of 'my_orders_bloc.dart';

abstract class MyOrdersState extends Equatable {
  const MyOrdersState();
  @override
  List<Object?> get props => [];
}

class MyOrdersInitial extends MyOrdersState {}

class MyOrdersSuccess extends MyOrdersState {
  final List<MyOrdersInfo> myorders;

  const MyOrdersSuccess(this.myorders);
}

class MyOrdersLoading extends MyOrdersState {}

class MyOrdersError extends MyOrdersState {
  final AppException exception;

  const MyOrdersError(this.exception);
  @override
  List<Object?> get props => [exception];
}
