part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeStarted extends HomeEvent {
  final bool isRefreshing;
  final String? sliderGroup;
  final int? data;

  const HomeStarted({
    required this.isRefreshing,
    this.sliderGroup,
    this.data,
  });
}

class HomeRefresh extends HomeEvent {}

class HomeClickedMessage extends HomeEvent {}
