part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
  @override
  List<Object?> get props => [];
}

class CategoryStarted extends CategoryEvent {
  final bool isRefreshing;

  const CategoryStarted({required this.isRefreshing});
}

class CategoryClickedButton extends CategoryEvent {}
