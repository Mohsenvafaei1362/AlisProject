import 'package:local_notification_flutter_project/ui/data/ClassInfo/my_orders_info.dart';
import 'package:dio/dio.dart';

abstract class IMyOrdersDataSource {
  Future<List<MyOrdersInfo>> myorders();
}

class MyOrdersRemoteDataSource implements IMyOrdersDataSource {
  final Dio httpClient;

  MyOrdersRemoteDataSource(this.httpClient);
  @override
  Future<List<MyOrdersInfo>> myorders() async {
    final response = await httpClient.get('path');
    final List<MyOrdersInfo> myorders = [];
    (response.data as List).forEach((element) {
      myorders.add(MyOrdersInfo.fromJson(element));
    });
    return myorders;
  }
}
