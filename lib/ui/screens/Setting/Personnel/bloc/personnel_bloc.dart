import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/personnel_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'personnel_event.dart';
part 'personnel_state.dart';

class PersonnelBloc extends Bloc<PersonnelEvent, PersonnelState> {
  final IPersonnelRepository personnelRepository;
  PersonnelBloc({required this.personnelRepository})
      : super(PersonnelInitial()) {
    on<PersonnelEvent>((event, emit) async {
      try {
        if (event is PersonnelStarted ||
            event is PersonnelSuccessSendPersonnel) {
          emit(PersonnelLoading());
          final getpersonnel = await personnelRepository.getpersonnel();
          emit(PersonnelSuccessgetPersonnel());
        } else if (event is PersonnelClickedButton) {
          emit(PersonnelLoading());
          final personnel = await personnelRepository.personnel(
            event.fname,
            event.lname,
            event.namestore,
            event.nationalcode,
            event.phonenumber,
          );
          emit(PersonnelSuccessSendPersonnel());
        }
      } catch (e) {
        emit(PersonnelErrorSendPersonnel(AppException()));
        emit(PersonnelErrorgetPersonnel(AppException()));
      }
    });
  }
}
