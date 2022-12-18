part of 'comment_product_bloc.dart';

abstract class CommentProductEvent extends Equatable {
  const CommentProductEvent();

  @override
  List<Object> get props => [];
}

class CommentProductStarted extends CommentProductEvent {}

class CommentProductClickdButton extends CommentProductEvent {
  final String txt1;
  final String txt2;
  final String txt3;
  final String txt4;

  CommentProductClickdButton(
    this.txt1,
    this.txt2,
    this.txt3,
    this.txt4,
  );
}
