part of 'preview_info_bloc.dart';

abstract class PreviewInfoState extends Equatable {
  @override
  List<Object> get props => [];
}

class PreviewInfoInitial extends PreviewInfoState {}

class PreviewInfoError extends PreviewInfoState {
  final AppException exception;
  PreviewInfoError(this.exception);

  @override
  List<Object> get props => [exception];
}

class PreviewInfoLoading extends PreviewInfoState {}

class PreviewInfoSuccess extends PreviewInfoState {}
