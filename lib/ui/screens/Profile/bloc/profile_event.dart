part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class ProfileStarted extends ProfileEvent {
  final AuthInfo authInfo;
  final bool? isActive;

  ProfileStarted(this.authInfo, this.isActive);
}

class ProfileClickedButtonEdit extends ProfileEvent {}

class ProfileClickedButtonExit extends ProfileEvent {}

class ProfileChanged extends ProfileEvent {
  final AuthInfo? authInfo;

  ProfileChanged(this.authInfo);
}
