part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final List<ClubInfo> club;
  final List<MessageCount> messageCount;
  final List<GholeInfo> ghole;

  const ProfileSuccess({
    required this.club,
    required this.ghole,
    required this.messageCount,
  });
}

class ProfileLoading extends ProfileState {}

class ProfileRequired extends ProfileState {}

class ProfileError extends ProfileState {
  final AppException exception;

  const ProfileError(this.exception);
  @override
  List<Object?> get props => [exception];
}
