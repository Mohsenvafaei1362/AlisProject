part of 'partners_bloc.dart';

abstract class PartnersEvent extends Equatable {
  const PartnersEvent();
  @override
  List<Object?> get props => [];
}

class PartnersStarted extends PartnersEvent {}

class PartnersClickedButton extends PartnersEvent {}
