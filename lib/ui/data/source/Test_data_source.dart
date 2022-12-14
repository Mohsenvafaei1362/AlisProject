import 'package:dio/dio.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/test_info.dart';

import '../ClassInfo/TestUser.dart';

abstract class ITestDataSource {
  Future<String> test();
  Future<List<TestUserInfo>> user(String token);
}

class TestRemoteDataSource implements ITestDataSource {
  final Dio httpClinet;

  TestRemoteDataSource(this.httpClinet);
  @override
  Future<String> test() async {
    // final response = await httpClinet.post('oauth2/token', data: {
    //   "client_id": 'ADQIZIVJAVUADDMJORJAWUPTQOWDFTUA',
    //   "client_secret": '85285667463997fa7962522054989818',
    //   'grant_type': 'password',
    //   "scope": '*',
    //   "username": 'afchangi',
    //   "password": '123456'
    // });
    // // final List<TestInfo> test = [];
    // // (response.data as List).forEach(
    // //   (element) {
    // //     test.add(TestInfo.fromJson(element));
    // //   },
    // // );
    // return response.data['access_token'];
    return '';
  }

  @override
  Future<List<TestUserInfo>> user(String token) async {
    final response = await Dio().get(
      'http://217.219.74.100/api/1.0/alis/users',
      options: Options(
        headers: {
          "Authorization": "Bearer 6cea9ca27a9ae16e5d717a65aea25b3a62d6db5c",
        },
      ),
    );

    final List<TestUserInfo> user = [];
    (response.data as List)
        .forEach((element) => {user.add(TestUserInfo.fromJson(element))});
    return user;
  }
}
