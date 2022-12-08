import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/add_point_screen_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_point_screen_event.dart';
part 'add_point_screen_state.dart';

class AddPointScreenBloc
    extends Bloc<AddPointScreenEvent, AddPointScreenState> {
  AddPointScreenBloc(AddPointScreenRepository addPointScreenRepository)
      : super(AddPointScreenInitial()) {
    on<AddPointScreenEvent>((event, emit) async {
      if (event is AddPointScreenClickedButton) {
        try {
          emit(AddPointScreenLoading());
          final response = await addPointScreenRepository.getPoint(
              event.title,
              event.lat,
              event.long,
              event.image,
              event.RegisterLevelRef,
              event.RegisterLevelCode,
              event.RegisterLvelTitle);
          emit(AddPointScreenSuccess());
        } catch (e) {
          emit(AddPointScreenError(AppException()));
        }
      }
    });
  }
}
