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

class DetailesClickedButton extends DetailesEvent {
  String name;
  final int userRef;
  final int productId;
  final int commentRef;
  final int sellsCenter;
  final bool liked;

  DetailesClickedButton({
    required this.name,
    required this.userRef,
    required this.productId,
    required this.sellsCenter,
    required this.liked,
    required this.commentRef,
  });
}
