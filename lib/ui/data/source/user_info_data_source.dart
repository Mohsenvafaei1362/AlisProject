import 'package:local_notification_flutter_project/ui/data/ClassInfo/User_info.dart';
import 'package:dio/dio.dart';

abstract class IUserInfoDataSource {
  Future<List<UserInfo>> userInfo();
}

class UserInfoRemoteDataSource implements IUserInfoDataSource {
  final Dio httpClient;

  UserInfoRemoteDataSource(this.httpClient);
  @override
  Future<List<UserInfo>> userInfo() async {
    final response = await httpClient.get('path');
    final List<UserInfo> userInfo = [];
    for (var element in (response.data as List)) {
      userInfo.add(UserInfo.fromJson(element));
    }
    return userInfo;
  }
}
