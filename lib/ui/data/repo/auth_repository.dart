import 'package:local_notification_flutter_project/ui/data/ClassInfo/auto_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/auth_data_source.dart';
import 'package:local_notification_flutter_project/ui/models/register/registergetsmstime.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> register(String phonenumber, String phoneId);
  Future<List<AuthInfo>> login(String username, String password);
  Future<void> refreshToken();
  Future<void> singOut();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> authChangeNotifire =
      ValueNotifier(null);
  late final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);
  @override
  Future<void> register(String phonenumber, String phoneId) async {
    final List<RegistergetsmstimeClass> authInfo =
        await dataSource.register(phonenumber, phoneId);
    // _persistAuthToken(authInfo);
    // print('access token is :${authInfo.accessToken}');
  }

  @override
  Future<List<AuthInfo>> login(String username, String password) async {
    final List<AuthInfo> authInfo = await dataSource.login(username, password);
    _persistAuthToken(authInfo);
    // print('access token is :${authInfo.accessToken}');
    return authInfo;
  }

  @override
  Future<void> refreshToken() async {
    // return dataSource.refreshToken('sdkmvklsvmsklvvvnjnjnvjksdv');
    // final AuthInfo authInfo =
    //     await dataSource.refreshToken('sdkmvklsvmsklvvvnjnjnvjksdv');
    // _persistAuthToken(authInfo);
  }

  Future<void> _persistAuthToken(List<AuthInfo> authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("userId", authInfo.first.userId.toString());
    // sharedPreferences.setString("refresh_token", authInfo.refreshToken);
    loadAuthInfo();
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    // final String accessToken =
    //     sharedPreferences.getString('access_token') ?? '';
    final String userId = sharedPreferences.getString('userId') ?? '';
    if (userId.isNotEmpty) {
      authChangeNotifire.value =
          AuthInfo(int.parse(userId), 0, 0, '', '', '', 0, 0, 0);
    }
  }

  @override
  Future<void> singOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangeNotifire.value = null;
  }
}
