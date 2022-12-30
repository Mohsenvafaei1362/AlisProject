part of 'detailes_bloc.dart';

abstract class DetailesEvent extends Equatable {
  const DetailesEvent();
  @override
  List<Object?> get props => [];
}

class DetailesStarted extends DetailesEvent {
  final int sellsCenter;
  final int productId;

  const DetailesStarted({
    required this.productId,
    required this.sellsCenter,
  });
}
