import 'package:local_notification_flutter_project/ui/data/ClassInfo/MyDevice_info.dart';
import 'package:dio/dio.dart';

abstract class IMyDeviceDataSource {
  Future<List<MyDeviceInfo>> mydevice();
}

class MyDeviceRemoteDataSource implements IMyDeviceDataSource {
  final Dio httpClient;

  MyDeviceRemoteDataSource(this.httpClient);
  @override
  Future<List<MyDeviceInfo>> mydevice() async {
    final response = await httpClient.get('path');
    final List<MyDeviceInfo> mydevice = [];
    for (var element in (response.data as List)) {
      mydevice.add(MyDeviceInfo.fromJson(element));
    }
    return mydevice;
  }
}
