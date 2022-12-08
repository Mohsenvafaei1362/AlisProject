part of 'role_screen_bloc.dart';

abstract class RoleScreenState extends Equatable {
  const RoleScreenState(this.controlEditdl);
  final bool controlEditdl;
  @override
  List<Object> get props => [];
}

class RoleScreenInitial extends RoleScreenState {
  const RoleScreenInitial(controlEditdl) : super(false);
}

class RoleScreenError extends RoleScreenState {
  final AppException exception;
  const RoleScreenError(this.exception) : super(false);
}

class RoleScreenSuccess extends RoleScreenState {
  const RoleScreenSuccess(controlEditdl) : super(false);
}

class RoleScreenLoading extends RoleScreenState {
  const RoleScreenLoading(controlEditdl) : super(false);
}

class RoleScreenNext extends RoleScreenState {
  const RoleScreenNext(controlEditdl) : super(false);
}
