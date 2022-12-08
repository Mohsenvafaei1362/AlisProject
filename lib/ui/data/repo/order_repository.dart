import 'package:local_notification_flutter_project/ui/data/ClassInfo/orderInfo.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/payment_recieptInfo.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/order_data_source.dart';

final orderRepository = OrderRepository(OrderRemoteDataSource(httpClient));

abstract class IOrderRepository extends IOrderDataSource {}

class OrderRepository implements IOrderRepository {
  final IOrderDataSource dataSource;
  OrderRepository(this.dataSource);
  @override
  Future<CreateOrderResult> create(CreateOrderParams params) =>
      dataSource.create(params);

  @override
  Future<PaymentRecieptData> getPaymentReciept(int orderId) =>
      dataSource.getPaymentReciept(orderId);
}
