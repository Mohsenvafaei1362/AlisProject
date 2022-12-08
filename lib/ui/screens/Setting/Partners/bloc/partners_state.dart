part of 'partners_bloc.dart';

abstract class PartnersState extends Equatable {
  const PartnersState();
  @override
  List<Object?> get props => [];
}

class PartnersInitial extends PartnersState {}

class PartnersSuccess extends PartnersState {
  final List<PartnersInfo> partners;

  const PartnersSuccess(this.partners);
}

class PartnersLoading extends PartnersState {}

class PartnersError extends PartnersState {
  final AppException exception;

  const PartnersError(this.exception);
  @override
  List<Object?> get props => [exception];
}
