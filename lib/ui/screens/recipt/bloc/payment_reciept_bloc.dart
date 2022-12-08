import 'package:local_notification_flutter_project/ui/data/ClassInfo/payment_recieptInfo.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/order_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_reciept_event.dart';
part 'payment_reciept_state.dart';

class PaymentRecieptBloc
    extends Bloc<PaymentRecieptEvent, PaymentRecieptState> {
  final IOrderRepository repository;
  PaymentRecieptBloc(this.repository) : super(PaymentRecieptLoading()) {
    on<PaymentRecieptEvent>((event, emit) async {
      if (event is PaymentRecieptStarted) {
        try {
          emit(PaymentRecieptLoading());
          final result = await repository.getPaymentReciept(event.orderId);
          emit(PaymentRecieptSuccess(result));
        } catch (e) {
          emit(PaymentRecieptError(AppException()));
        }
      }
    });
  }
}
