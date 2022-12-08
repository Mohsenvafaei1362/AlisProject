import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/IdentificationCode_repository.dart';
import 'package:local_notification_flutter_project/ui/models/DL/putdl.dart';
import 'package:local_notification_flutter_project/ui/models/register/putregistermemberlevel.dart';
import 'package:local_notification_flutter_project/ui/models/user/putuser.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Law/law.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'identification_code_event.dart';
part 'identification_code_state.dart';

final UiDl _dl = Get.put(UiDl());

class IdentificationCodeBloc
    extends Bloc<IdentificationCodeEvent, IdentificationCodeState> {
  final IdentificationCodeRepository identificationCodeRepository;
  IdentificationCodeBloc(this.identificationCodeRepository)
      : super(IdentificationCodeInitial()) {
    on<IdentificationCodeEvent>((event, emit) async {
      try {
        if (event is IdentificationCodeClickedButton) {
          emit(IdentificationCodeLoading());
          await putdl();
          await putuser(_dl.UserName.value, '-1', _dl.DlId.value);
          await putregistermemberlevel(2, '2', 'LoginThree');

          // final identificationCode =
          //     await identificationCodeRepository.identificationCode(event.code);
          emit(IdentificationCodeSuccess());
        } else if (event is IdentificationCodeSuccess) {
          Get.to(Law());
        }
      } catch (e) {
        emit(IdentificationCodeError(AppException()));
      }
    });
  }
}
