import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/previewInfo_repository.dart';
import 'package:local_notification_flutter_project/ui/models/register/putregistermemberlevel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'preview_info_event.dart';
part 'preview_info_state.dart';

class PreviewInfoBloc extends Bloc<PreviewInfoEvent, PreviewInfoState> {
  PreviewInfoBloc(IPreviewINfoRepository previewINfoRepository)
      : super(PreviewInfoInitial()) {
    on<PreviewInfoEvent>((event, emit) async {
      try {
        if (event is PreviewInfoStarted) {
          // emit(PreviewInfoLoading());
          // final previewInfo = await previewINfoRepository.getAllInfo();
          // emit(PreviewInfoSuccess(preivewInfo: previewInfo));
        } else if (event is PreviewInfoClickedButton) {
          emit(PreviewInfoLoading());
          await putregistermemberlevel(7, '7', 'Congratulation');
          emit(PreviewInfoSuccess());
        }
      } catch (e) {
        emit(PreviewInfoError(AppException()));
      }
    });
  }
}
