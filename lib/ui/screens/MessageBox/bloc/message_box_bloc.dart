import 'package:flutter/cupertino.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/Club_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/Ghole_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/message_box_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Club_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Ghole_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/message_box_repository.dart';
import 'package:local_notification_flutter_project/ui/models/message_box/message_box_post/message_post1.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'message_box_event.dart';
part 'message_box_state.dart';

var message, ghole, club;

class MessageBoxBloc extends Bloc<MessageBoxEvent, MessageBoxState> {
  final IMessageBoxRepository messageBoxRepository;
  final IMessageCountRepository messageCountRepository;
  final IGholeRepository gholeRepository;
  final IClubRepository clubRepository;
  MessageBoxBloc({
    required this.messageBoxRepository,
    required this.messageCountRepository,
    required this.clubRepository,
    required this.gholeRepository,
  }) : super(MessageBoxLoading()) {
    on<MessageBoxEvent>((event, emit) async {
      try {
        if (event is MessageBoxStarted) {
          emit(MessageBoxLoading());
          final messageInfo = await messageCountRepository.messageCount();
          final gholeInfo = await gholeRepository.ghole();
          final clubInfo = await clubRepository.club();
          message = messageInfo;
          ghole = gholeInfo;
          club = clubInfo;

          emit(
            MessageBoxSuccess(
              club: clubInfo,
              ghole: gholeInfo,
              messageCount: messageInfo,
            ),
          );
        } else if (event is MessageBoxClicked) {
          final successState = (state as MessageBoxSuccess);
          emit(MessageBoxLoading());
          final index = successState.messageCount
              .indexWhere((element) => element.ID == event.messageId);
          successState.messageCount[index].isActive = false;
          // emit(MessageBoxNextPage());

          Get.to(
            () => Message_Post1(message: message, index: index),
          );
          // emit(MessageBoxSuccess(message: message))
        }
      } catch (e) {
        emit(MessageBoxError(AppException()));
      }
    });
  }
}
