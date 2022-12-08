import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/confirmation_repository.dart';
import 'package:local_notification_flutter_project/ui/models/register/putregistermemberlevel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'confirmation_event.dart';
part 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  ConfirmationBloc({required ConfirmationRepository confimationRepository})
      : super(ConfirmationInitial()) {
    on<ConfirmationEvent>((event, emit) async {
      try {
        if (event is ConfirmationStarted) {
          emit(ConfirmationLoading());
          final getstate = await confimationRepository.confirmationState();
          // print(getstate.runtimeType);
          emit(ConfirmationSuccess(getState: getstate.toString()));
        } else if (event is ConfirmationClickedButton) {
          emit(ConfirmationLoading());
          await putregistermemberlevel(8, '8', 'EndRegister');

          // Get.to(EndRegister());
        }
      } catch (e) {
        emit(ConfirmationError(AppException()));
      }
    });
  }
}
