part of 'law_screen_bloc.dart';

abstract class LawScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class LawScreenInitial extends LawScreenState {}

// class LawScreenStarted extends LawScreenState {}

class LawScreenError extends LawScreenState {
  final AppException exception;
  LawScreenError(this.exception);
}

class LawScreenSuccess extends LawScreenState {}

class LawScreenLoading extends LawScreenState {}
