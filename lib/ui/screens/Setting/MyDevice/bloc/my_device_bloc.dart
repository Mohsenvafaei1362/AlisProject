import 'package:local_notification_flutter_project/ui/data/ClassInfo/MyDevice_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/my_device_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_device_event.dart';
part 'my_device_state.dart';

class MyDeviceBloc extends Bloc<MyDeviceEvent, MyDeviceState> {
  final IMyDeviceRepository myDeviceRepository;
  MyDeviceBloc({required this.myDeviceRepository}) : super(MyDeviceInitial()) {
    on<MyDeviceEvent>((event, emit) async {
      try {
        if (event is MyDeviceStarted) {
          emit(MyDeviceLoading());
          final mydevice = await myDeviceRepository.mydevice();
          emit(MyDeviceSuccess(mydevice));
        }
      } catch (e) {
        emit(MyDeviceError(AppException()));
      }
    });
  }
}
