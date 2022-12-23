part of 'detailes_bloc.dart';

abstract class DetailesEvent extends Equatable {
  const DetailesEvent();
  @override
  List<Object?> get props => [];
}

class DetailesStarted extends DetailesEvent {
  final int data;
  final int categoryId;

  const DetailesStarted(this.data, this.categoryId);
}
