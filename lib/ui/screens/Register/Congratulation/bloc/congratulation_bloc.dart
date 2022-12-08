import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Congratulation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'congratulation_event.dart';
part 'congratulation_state.dart';

class CongratulationBloc
    extends Bloc<CongratulationEvent, CongratulationState> {
  final ICongratulationRepository congratulationRepository;
  CongratulationBloc({required this.congratulationRepository})
      : super(CongratulationInitial()) {
    on<CongratulationEvent>((event, emit) async {
      if (event is CongratulationStarted) {
        emit(CongratulationLoading());
        final isActive = await congratulationRepository.isActive();

        // getdl();
        // Get.to(() => Confirmation());
        // await putregistermemberlevel(8, '8', 'Confirmation');
        emit(CongratulationSuccess(isActive));

        try {
          emit(CongratulationLoading());
        } catch (e) {
          emit(CongratulationError(AppException()));
        }
      }
    });
  }
}
