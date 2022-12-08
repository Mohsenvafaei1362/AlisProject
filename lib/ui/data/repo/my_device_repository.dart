import 'package:local_notification_flutter_project/ui/data/ClassInfo/MyDevice_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/my_device_data_source.dart';

final myDeviceRepository =
    MyDeviceRepository(MyDeviceRemoteDataSource(httpClient));

abstract class IMyDeviceRepository {
  Future<List<MyDeviceInfo>> mydevice();
}

class MyDeviceRepository implements IMyDeviceRepository {
  final IMyDeviceDataSource dataSource;

  MyDeviceRepository(this.dataSource);
  @override
  Future<List<MyDeviceInfo>> mydevice() => dataSource.mydevice();
}
