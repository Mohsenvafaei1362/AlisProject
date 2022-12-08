import 'package:local_notification_flutter_project/ui/data/ClassInfo/mystore_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/my_store_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_store_event.dart';
part 'my_store_state.dart';

class MyStoreBloc extends Bloc<MyStoreEvent, MyStoreState> {
  final IMyStoreRepository myStoreRepository;
  MyStoreBloc({required this.myStoreRepository}) : super(MyStoreInitial()) {
    on<MyStoreEvent>((event, emit) async {
      try {
        if (event is MyStoreStarted) {
          emit(MyStoreLoading());
          final store = await myStoreRepository.mystore();
          emit(MyStoreSuccess(store));
        }
      } catch (e) {
        emit(MyStoreError(AppException()));
      }
    });
  }
}
