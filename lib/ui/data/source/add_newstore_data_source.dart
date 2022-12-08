import 'package:local_notification_flutter_project/ui/data/ClassInfo/AddNewStore_info.dart';
import 'package:dio/dio.dart';

abstract class IAddNewStoreDataSource {
  Future<List<AddNewStoreInfo>> newstore(
    String name,
    String address,
    String image,
    String branchtype,
    int phoneNumber,
    bool isactive,
  );
}

class AddNewStoreRemoteDataSource implements IAddNewStoreDataSource {
  final Dio httpClient;

  AddNewStoreRemoteDataSource(this.httpClient);
  @override
  Future<List<AddNewStoreInfo>> newstore(
    String name,
    String address,
    String image,
    String branchtype,
    int phoneNumber,
    bool isactive,
  ) async {
    if (isactive == true) {
      final response = await httpClient.put(
        'path',
        data: {
          'name': name,
          'address': address,
          'image': image,
          'branchtype': branchtype,
          'phonenumber': phoneNumber,
        },
      );
      final List<AddNewStoreInfo> newstore = [];
      for (var element in (response.data as List)) {
        newstore.add(AddNewStoreInfo.fromJson(element));
      }
      return newstore;
    } else {
      final response = await httpClient.post(
        'path',
        data: {
          'name': name,
          'address': address,
          'image': image,
          'branchtype': branchtype,
          'phonenumber': phoneNumber,
        },
      );
      final List<AddNewStoreInfo> newstore = [];
      for (var element in (response.data as List)) {
        newstore.add(AddNewStoreInfo.fromJson(element));
      }
      return newstore;
    }
  }
}
