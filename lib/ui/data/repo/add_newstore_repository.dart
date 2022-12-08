import 'package:local_notification_flutter_project/ui/data/ClassInfo/AddNewStore_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/add_newstore_data_source.dart';

final addStoreRepository =
    AddStoreRepository(AddNewStoreRemoteDataSource(httpClient));

abstract class IAddStoreRepository {
  // Future<List<AddNewStoreInfo>> updatestore();
  Future<List<AddNewStoreInfo>> newstore(
    String name,
    String address,
    String image,
    String branchtype,
    int phoneNumber,
    bool isactive,
  );
}

class AddStoreRepository implements IAddStoreRepository {
  final IAddNewStoreDataSource dataSource;

  AddStoreRepository(this.dataSource);
  @override
  Future<List<AddNewStoreInfo>> newstore(
    String name,
    String address,
    String image,
    String branchtype,
    int phoneNumber,
    bool isactive,
  ) {
    return dataSource.newstore(
        name, address, image, branchtype, phoneNumber, isactive);
  }
}
