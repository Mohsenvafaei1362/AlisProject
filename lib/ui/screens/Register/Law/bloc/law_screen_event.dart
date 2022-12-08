part of 'law_screen_bloc.dart';

abstract class LawScreenEvent extends Equatable {
  const LawScreenEvent();
  @override
  List<Object> get props => [];
}

class LawScreenStarted extends LawScreenEvent {}

class LawScreenClickButton extends LawScreenEvent {
  const LawScreenClickButton();
}
