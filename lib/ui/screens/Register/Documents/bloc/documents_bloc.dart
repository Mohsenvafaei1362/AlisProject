import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/documents_repository.dart';
import 'package:local_notification_flutter_project/ui/models/Dto/DocumentsDto.dart';
import 'package:local_notification_flutter_project/ui/models/register/putregistermemberlevel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'documents_event.dart';
part 'documents_state.dart';

class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  DocumentsBloc(IDocumentsRepository documentsRepository)
      : super(DocumentsInitial()) {
    on<DocumentsEvent>((event, emit) async {
      try {
        if (event is DocumentsClickButton) {
          emit(DocumentsLoading());
          await documentsRepository.imageUrl(event.document);
          emit(DocumentsSuccess());
        } else if (event is DocumentsNextPage) {
          emit(DocumentsLoading());
          await putregistermemberlevel(6, '6', "PreviewInfo");
          emit(DocumentsSuccess());
          // Get.to(const Congratulation());
          // Get.to(Confirmation());
        }
      } catch (e) {
        emit(DocumentsError(AppException()));
      }
    });
  }
}
