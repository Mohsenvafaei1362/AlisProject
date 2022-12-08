part of 'message_box_bloc.dart';

abstract class MessageBoxState extends Equatable {
  const MessageBoxState();
  @override
  List<Object?> get props => [];
}

class MessageBoxInitial extends MessageBoxState {}

class MessageBoxSuccess extends MessageBoxState {
  final List<ClubInfo> club;
  final List<MessageCount> messageCount;
  final List<GholeInfo> ghole;

  const MessageBoxSuccess({
    required this.messageCount,
    required this.club,
    required this.ghole,
  });
}

class MessageBoxLoading extends MessageBoxState {}

class MessageBoxNextPage extends MessageBoxState {}

class MessageBoxError extends MessageBoxState {
  final AppException exception;

  const MessageBoxError(this.exception);
  @override
  List<Object?> get props => [exception];
}
