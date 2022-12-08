part of 'my_orders_bloc.dart';

abstract class MyOrdersEvent extends Equatable {
  const MyOrdersEvent();
  @override
  List<Object?> get props => [];
}

class MyOrdersStarted extends MyOrdersEvent {}

class MyOrdersClickedButtonFollowUp extends MyOrdersEvent {}

class MyOrdersClickedButtonOrdersOpen extends MyOrdersEvent {}

class MyOrdersClickedButtonOrdersClose extends MyOrdersEvent {}

class MyOrdersClickedButtonComplaint extends MyOrdersEvent {}
