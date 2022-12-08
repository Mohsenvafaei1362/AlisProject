import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/add_newstore_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'new_store_event.dart';
part 'new_store_state.dart';

class NewStoreBloc extends Bloc<NewStoreEvent, NewStoreState> {
  final IAddStoreRepository addStoreRepository;
  NewStoreBloc({required this.addStoreRepository}) : super(NewStoreInitial()) {
    on<NewStoreEvent>((event, emit) async {
      try {
        if (event is NewStoreClickedButton) {
          emit(NewStoreLoading());
          final newstore = await addStoreRepository.newstore(
            event.name,
            event.address,
            event.image,
            event.branchtype,
            event.phoneNumber,
            event.isactive,
          );
          emit(NewStoreSuccess());
        }
      } catch (e) {
        emit(NewStoreError(AppException()));
      }
    });
  }
}
