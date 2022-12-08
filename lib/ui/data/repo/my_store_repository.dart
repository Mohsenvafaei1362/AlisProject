import 'package:local_notification_flutter_project/ui/data/ClassInfo/mystore_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/my_store_data_source.dart';

final myStoreRepository =
    MyStoreRepository(MyStoreRemoteDataSource(httpClient));

abstract class IMyStoreRepository {
  Future<List<MyStoreInfo>> mystore();
}

class MyStoreRepository implements IMyStoreRepository {
  final IMyStoreDataSource dataSource;

  MyStoreRepository(this.dataSource);
  @override
  Future<List<MyStoreInfo>> mystore() => dataSource.mystore();
}
