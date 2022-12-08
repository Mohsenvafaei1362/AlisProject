import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/repo/recivecode_login_repository.dart';

part 'recivecode_event.dart';
part 'recivecode_state.dart';

class RecivecodeBloc extends Bloc<RecivecodeEvent, RecivecodeState> {
  RecivecodeBloc(IReciveCodeRepository reciveCodeRepository)
      : super(RecivecodeInitial()) {
    on<RecivecodeEvent>((event, emit) async {
      try {
        if (event is ReciveCodeButtonClicked) {
          emit(ReciveCodeLoading());
          await reciveCodeRepository.Code(event.code);
          emit(ReciveCodeSuccess());
          // getdl();

          // await authRepository.register(event.password);
          // emit(AuthSuccess());
        } else if (event is ReciveCodeSuccess) {
          emit(ReciveCodeLoading());
          // getdl();
        }
      } catch (e) {
        emit(ReciveCodeError(AppException()));
      }
    });
  }
}
