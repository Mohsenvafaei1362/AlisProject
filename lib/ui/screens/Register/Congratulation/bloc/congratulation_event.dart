part of 'congratulation_bloc.dart';

abstract class CongratulationEvent extends Equatable {
  const CongratulationEvent();
  @override
  List<Object?> get props => [];
}

class CongratulationStarted extends CongratulationEvent {}

class CongratulationButtonClicked extends CongratulationEvent {}
