import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/lawRepository.dart';
import 'package:local_notification_flutter_project/ui/models/register/putregistermemberlevel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'law_screen_event.dart';
part 'law_screen_state.dart';

class LawScreenBloc extends Bloc<LawScreenEvent, LawScreenState> {
  LawScreenBloc(ILawScreenRepository lawScreenRepository)
      : super(LawScreenInitial()) {
    on<LawScreenEvent>((event, emit) async {
      try {
        if (event is LawScreenClickButton) {
          emit(LawScreenLoading());
          // await lawScreenRepository.law(event.RegisterLevelRef,
          //     event.RegisterLevelCode, event.RegisterLvelTitle);
          putregistermemberlevel(3, '3', 'Role');
          emit(LawScreenSuccess());
        }
      } catch (e) {
        emit(LawScreenError(AppException()));
      }
    });
  }
}
