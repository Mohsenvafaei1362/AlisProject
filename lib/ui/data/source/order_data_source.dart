import 'package:local_notification_flutter_project/ui/data/ClassInfo/orderInfo.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/payment_recieptInfo.dart';
import 'package:dio/dio.dart';

abstract class IOrderDataSource {
  Future<CreateOrderResult> create(CreateOrderParams params);
  Future<PaymentRecieptData> getPaymentReciept(int orderId);
}

class OrderRemoteDataSource implements IOrderDataSource {
  final Dio httpClient;
  OrderRemoteDataSource(this.httpClient);
  @override
  Future<CreateOrderResult> create(CreateOrderParams params) async {
    final response = await httpClient.post(
      'order',
      data: {
        'firstName': params.firstName,
        'lastName': params.lastName,
        'phoneNumber': params.phoneNumber,
        'postal_code': params.postalCode,
        'address': params.address,
        'payment_method': params.paymentMethod == PaymentMethod.online
            ? 'online'
            : 'cash_on_delivery',
      },
    );
    return CreateOrderResult.fromJson(response.data);
  }

  @override
  Future<PaymentRecieptData> getPaymentReciept(int orderId) async {
    final response = await httpClient.get('order/checkout?order_id=$orderId');
    return PaymentRecieptData.fromJson(response.data);
  }
}
