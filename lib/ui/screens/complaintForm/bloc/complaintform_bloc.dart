import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/complaint_form_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'complaintform_event.dart';
part 'complaintform_state.dart';

class ComplaintformBloc extends Bloc<ComplaintformEvent, ComplaintformState> {
  final ICompaintFormRepository compaintFormRepository;
  ComplaintformBloc({required this.compaintFormRepository})
      : super(ComplaintformInitial()) {
    on<ComplaintformEvent>((event, emit) async {
      try {
        if (event is ComplaintformClickedButton) {
          emit(ComplaintformLoading());
          final complaint = await compaintFormRepository.complaint(
            event.title,
            event.fullname,
            event.email,
            event.phone,
            event.codeorder,
            event.description,
            event.image,
          );
          emit(ComplaintformSuccess());
        }
      } catch (e) {
        emit(ComplaintformError(AppException()));
      }
    });
  }
}
