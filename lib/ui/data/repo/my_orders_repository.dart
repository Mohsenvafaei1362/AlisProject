import 'package:local_notification_flutter_project/ui/data/ClassInfo/my_orders_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/my_orders_data_source.dart';

final myOrdersRepository =
    MyOrdersRepository(MyOrdersRemoteDataSource(httpClient));

abstract class IMyOrdersRepository {
  Future<List<MyOrdersInfo>> myorders();
}

class MyOrdersRepository implements IMyOrdersRepository {
  final IMyOrdersDataSource dataSource;

  MyOrdersRepository(this.dataSource);
  @override
  Future<List<MyOrdersInfo>> myorders() => dataSource.myorders();
}
