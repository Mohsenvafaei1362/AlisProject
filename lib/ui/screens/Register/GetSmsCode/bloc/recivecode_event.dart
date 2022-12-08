part of 'recivecode_bloc.dart';

abstract class RecivecodeEvent extends Equatable {
  const RecivecodeEvent();
  @override
  List<Object> get props => [];
}

class ReciveCodeStarted extends RecivecodeEvent {}

class ReciveCodeButtonClicked extends RecivecodeEvent {
  final int code;
  const ReciveCodeButtonClicked(this.code);
}
