import 'package:local_notification_flutter_project/ui/data/ClassInfo/orderInfo.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/order_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  final IOrderRepository repository;
  ShippingBloc(this.repository) : super(ShippingInitial()) {
    on<ShippingEvent>((event, emit) async {
      if (event is ShippingCreateOrder) {
        try {
          emit(ShippingLoading());
          final result = await repository.create(event.params);
          emit(ShippingSuccess(result));
        } catch (e) {
          emit(ShippingError(AppException()));
        }
      }
    });
  }
}
