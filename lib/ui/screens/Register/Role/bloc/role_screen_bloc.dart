import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/role_repository.dart';
import 'package:local_notification_flutter_project/ui/models/Dto/UserUpdateDto.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'role_screen_event.dart';
part 'role_screen_state.dart';

class RoleScreenBloc extends Bloc<RoleScreenEvent, RoleScreenState> {
  bool controlEditdl;
  RoleScreenBloc(IRoleScreenRepository roleScreenRepository,
      {this.controlEditdl = false})
      : super(RoleScreenInitial(controlEditdl)) {
    on<RoleScreenEvent>((event, emit) async {
      try {
        if (event is RoleScreenClickButton) {
          emit(RoleScreenLoading(controlEditdl));
          await roleScreenRepository.roleinfo(event.userUpdateDto);
          emit(RoleScreenSuccess(controlEditdl));
        } else if (event is RoleScreenError) {
          controlEditdl = !controlEditdl;
        }
      } catch (e) {
        emit(RoleScreenError(AppException()));
      }
    });
  }
}
