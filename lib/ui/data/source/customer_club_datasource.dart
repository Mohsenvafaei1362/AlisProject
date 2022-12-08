import 'package:local_notification_flutter_project/ui/data/ClassInfo/customer_clubInfo.dart';
import 'package:dio/dio.dart';

abstract class ICustomerClubDataSource {
  Future<List<CustomerClubInfo>> getUserInfo();
}

class CustomerClubRemoteDataSource implements ICustomerClubDataSource {
  late final Dio httpClient;
  CustomerClubRemoteDataSource(this.httpClient);
  @override
  Future<List<CustomerClubInfo>> getUserInfo() async {
    final response = await httpClient.get('path');
    final List<CustomerClubInfo> getUserInfo = [];
    (response.data as List).forEach((element) {
      getUserInfo.add(CustomerClubInfo.fromJson(element));
    });
    return getUserInfo;
  }
}
