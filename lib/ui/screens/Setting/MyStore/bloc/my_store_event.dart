part of 'my_store_bloc.dart';

abstract class MyStoreEvent extends Equatable {
  const MyStoreEvent();
  @override
  List<Object?> get props => [];
}

class MyStoreStarted extends MyStoreEvent {}

class MyStoreClickedButton extends MyStoreEvent {}
