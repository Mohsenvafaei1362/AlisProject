import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/change_password_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final IChangePasswordRepository changePasswordRepository;
  ChangePasswordBloc({required this.changePasswordRepository})
      : super(ChangePasswordInitial()) {
    on<ChangePasswordEvent>((event, emit) async {
      try {
        if (event is ChangePasswordClickedButton) {
          emit(ChangePasswordLoading());
          // await Future.delayed(Duration(seconds: 10));
          final pass =
              await changePasswordRepository.pass(event.oldpass, event.newpass);
          emit(ChangePasswordSuccess());
        }
      } catch (e) {
        emit(ChangePasswordError(AppException()));
      }
    });
  }
}
