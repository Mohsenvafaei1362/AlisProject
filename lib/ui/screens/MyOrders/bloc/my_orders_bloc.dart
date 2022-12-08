import 'package:local_notification_flutter_project/ui/data/ClassInfo/my_orders_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/my_orders_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_orders_event.dart';
part 'my_orders_state.dart';

class MyOrdersBloc extends Bloc<MyOrdersEvent, MyOrdersState> {
  final IMyOrdersRepository myOrdersRepository;
  MyOrdersBloc({required this.myOrdersRepository}) : super(MyOrdersInitial()) {
    on<MyOrdersEvent>((event, emit) async {
      try {
        if (state is MyOrdersStarted) {
          emit(MyOrdersLoading());
          final myorder = await myOrdersRepository.myorders();
          emit(MyOrdersSuccess(myorder));
        }
      } catch (e) {
        emit(MyOrdersError(AppException()));
      }
    });
  }
}
