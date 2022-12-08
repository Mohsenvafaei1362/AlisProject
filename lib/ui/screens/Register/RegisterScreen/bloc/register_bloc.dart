import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/registerScreen_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(IRegisterScreenRepository registerScreenRepository)
      : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      try {
        if (event is RegisterClickButton) {
          emit(RegisterLoading());
          await registerScreenRepository.getPhone(event.phone, event.phoneId);
          emit(RegisterSuccess());

          // await authRepository.register(event.password);
          // emit(AuthSuccess());
        }
      } catch (e) {
        emit(RegisterError(AppException()));
      }
    });
  }
}
