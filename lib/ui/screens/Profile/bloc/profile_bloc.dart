import 'package:local_notification_flutter_project/ui/data/ClassInfo/Club_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/Ghole_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/auto_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/message_box_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Club_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Ghole_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/message_box_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IClubRepository clubRepository;
  final IGholeRepository gholeRepository;
  final IMessageBoxRepository messageBoxRepository;
  ProfileBloc({
    required this.clubRepository,
    required this.gholeRepository,
    required this.messageBoxRepository,
  }) : super(ProfileLoading()) {
    on<ProfileEvent>((event, emit) async {
      try {
        if (event is ProfileStarted) {
          final authinfo = event.authInfo;
          if (authinfo == null) {
            // if (authinfo == null || authinfo.accessToken.isEmpty) {
            emit(ProfileRequired());
          }
          emit(ProfileLoading());
          final messageCount = await messageCountRepository.messageCount();
          final clubinfo = await clubRepository.club();
          final gholeinfo = await gholeRepository.ghole();
          emit(
            ProfileSuccess(
              club: clubinfo,
              ghole: gholeinfo,
              messageCount: messageCount,
            ),
          );
        } else if (event is ProfileChanged) {
          if (event.authInfo == null) {
            emit(ProfileRequired());
          } else {
            if (event is ProfileRequired) {
              emit(ProfileLoading());
              final messageCount = await messageCountRepository.messageCount();
              final clubinfo = await clubRepository.club();
              final gholeinfo = await gholeRepository.ghole();
              emit(
                ProfileSuccess(
                  club: clubinfo,
                  ghole: gholeinfo,
                  messageCount: messageCount,
                ),
              );
            }
          }
        }
      } catch (e) {
        emit(ProfileError(AppException()));
      }
    });
  }
}
