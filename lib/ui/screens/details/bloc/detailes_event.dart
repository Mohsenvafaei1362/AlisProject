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

class DetailesLikeClickedButton extends DetailesEvent {
  String name;
  final int userRef;
  final int productId;
  final int commentRef;
  final int sellsCenter;
  final bool liked;

  DetailesLikeClickedButton({
    required this.name,
    required this.userRef,
    required this.productId,
    required this.sellsCenter,
    required this.liked,
    required this.commentRef,
  });
}

class DetailesIncrementClickedButton extends DetailesEvent {
  final int productId;
  final int value;

  DetailesIncrementClickedButton(this.productId, this.value);
}

class DetailesDecrementClickedButton extends DetailesEvent {
  final int productId;
  final int value;
  DetailesDecrementClickedButton(this.productId, this.value);
}
