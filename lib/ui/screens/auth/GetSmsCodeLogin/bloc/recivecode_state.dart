part of 'recivecode_bloc.dart';

abstract class RecivecodeState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecivecodeInitial extends RecivecodeState {}

class RecivecodeStarted extends RecivecodeState {}

class ReciveCodeError extends RecivecodeState {
  late final AppException appException;
  ReciveCodeError(this.appException);
}

class ReciveCodeLoading extends RecivecodeState {}

class ReciveCodeSuccess extends RecivecodeState {}
