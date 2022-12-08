part of 'preview_info_bloc.dart';

abstract class PreviewInfoEvent extends Equatable {
  const PreviewInfoEvent();
  @override
  List<Object> get props => [];
}

class PreviewInfoStarted extends PreviewInfoEvent {}

class PreviewInfoClickedButton extends PreviewInfoEvent {}

class PreviewInfoRefresh extends PreviewInfoEvent {}
