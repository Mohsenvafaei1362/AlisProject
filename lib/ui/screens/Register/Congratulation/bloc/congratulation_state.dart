part of 'congratulation_bloc.dart';

abstract class CongratulationState extends Equatable {
  const CongratulationState();
  @override
  List<Object?> get props => [];
}

class CongratulationInitial extends CongratulationState {}

class CongratulationError extends CongratulationState {
  final AppException exception;

  const CongratulationError(this.exception);

  @override
  List<Object?> get props => [exception];
}

class CongratulationLoading extends CongratulationState {}

class CongratulationSuccess extends CongratulationState {
  final int isActive;

  const CongratulationSuccess(this.isActive);
}
