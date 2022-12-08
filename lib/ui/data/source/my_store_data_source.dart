import 'package:local_notification_flutter_project/ui/data/ClassInfo/mystore_info.dart';
import 'package:dio/dio.dart';

abstract class IMyStoreDataSource {
  Future<List<MyStoreInfo>> mystore();
}

class MyStoreRemoteDataSource implements IMyStoreDataSource {
  final Dio httpClient;

  MyStoreRemoteDataSource(this.httpClient);
  @override
  Future<List<MyStoreInfo>> mystore() async {
    final response = await httpClient.get('path');
    final List<MyStoreInfo> mystore = [];
    for (var element in (response.data as List)) {
      mystore.add(MyStoreInfo.fromJson(element));
    }
    return mystore;
  }
}
