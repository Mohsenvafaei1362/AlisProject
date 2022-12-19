part of 'edit_info_user_bloc.dart';

abstract class EditInfoUserState extends Equatable {
  const EditInfoUserState();

  @override
  List<Object> get props => [];
}

class EditInfoUserInitial extends EditInfoUserState {}

class EditInfoUserSuccess extends EditInfoUserState {}

class EditInfoUserLoading extends EditInfoUserState {}

class EditInfoUserError extends EditInfoUserState {
  final AppException exception;

  EditInfoUserError(this.exception);
  @override
  List<Object> get props => [exception];
}
