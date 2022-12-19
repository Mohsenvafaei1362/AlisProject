import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/EditInfoUser_Repository.dart';

part 'edit_info_user_event.dart';
part 'edit_info_user_state.dart';

class EditInfoUserBloc extends Bloc<EditInfoUserEvent, EditInfoUserState> {
  final IEditInfoUserRepository editInfoUserRepository;
  EditInfoUserBloc({required this.editInfoUserRepository})
      : super(EditInfoUserInitial()) {
    on<EditInfoUserEvent>((event, emit) async {
      try {
        if (event is EditInfoUserClickedButton) {
          emit(EditInfoUserLoading());
          final response = await editInfoUserRepository.edit(
            event.fname,
            event.lname,
            event.email,
            event.phone,
          );
          emit(EditInfoUserSuccess());
        }
      } catch (e) {
        emit(EditInfoUserError(AppException()));
      }
    });
  }
}
