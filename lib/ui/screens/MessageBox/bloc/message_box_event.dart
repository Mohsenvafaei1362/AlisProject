part of 'message_box_bloc.dart';

abstract class MessageBoxEvent extends Equatable {
  const MessageBoxEvent();
  @override
  List<Object?> get props => [];
}

class MessageBoxStarted extends MessageBoxEvent {}

class MessageBoxClicked extends MessageBoxEvent {
  final int messageId;

  const MessageBoxClicked(this.messageId);
}
