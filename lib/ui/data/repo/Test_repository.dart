import 'package:flutter/material.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/TestUser.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/auto_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/test_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/Test_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final testRepository = TestRepository(TestRemoteDataSource(httpClient2));

abstract class ITestRepository {
  Future<String> test();
  Future<List<TestUserInfo>> user(String token);
}

class TestRepository implements ITestRepository {
  static final ValueNotifier<AuthInfo?> authChangeNotifire =
      ValueNotifier(null);
  final ITestDataSource dataSource;

  TestRepository(this.dataSource);
  @override
  Future<String> test() => dataSource.test();

  @override
  Future<List<TestUserInfo>> user(String token) => dataSource.user(token);
}

Future<void> _persistAuthToken(List<TestInfo> authInfo) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sharedPreferences.setString("token", authInfo.first.access_token);
}
