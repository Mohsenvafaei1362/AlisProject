import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/auto_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/common/http_response_validator.dart';
import 'package:local_notification_flutter_project/ui/models/register/registergetsmstime.dart';
import 'package:local_notification_flutter_project/ui/models/register/registerrequest.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

final UiPhoneController phoneController = Get.put(UiPhoneController());
final UiLog log = Get.put(UiLog());
final UiDuration1 duration1 = Get.put(UiDuration1());
final UserInfo _userInfo = Get.put(UserInfo());

abstract class IAuthDataSource {
  Future<List<AuthInfo>> login(String username, String password);
  Future<List<RegistergetsmstimeClass>> register(
      String phonenumber, String phoneId);
  Future<AuthInfo> refreshToken(String token);
}

class AuthRemoteDataSource
    with HttpResponseValidator
    implements IAuthDataSource {
  late final Dio httpClient;
  AuthRemoteDataSource(this.httpClient);

  @override
  Future<List<AuthInfo>> login(String username, String password) async {
    final response = await httpClient.get(
      'User',
      queryParameters: {
        "UserName": username,
        "Pass": password,
        // "model": "register",
        // "clientsecret": Constanst.clientSecret,
      },
    );

    if (response.statusCode != 200) {
      throw AppException();
    } else {
      final List<AuthInfo> authInfo = [];
      if (response.data is List<dynamic>) {
        if ((response.data as List<dynamic>).length == 1) {
          var element =
              AuthInfo.fromJson((response.data as List<dynamic>).first);
          authInfo.add(element);
          _userInfo.DlRef.value = element.dlRef;
          _userInfo.RoleId.value = element.roleId;
          _userInfo.RoleTitle.value = element.roleTitle;
          _userInfo.RoleTitleEn.value = element.roleTitleEn;
          _userInfo.UserId.value = element.userId;
          _userInfo.UserName.value = element.userName;
          _userInfo.visitor.value = element.visitorRef;
          _userInfo.sellsCenter.value = element.sellsCenterRef;
          _userInfo.userGroups.value = element.usersGroupRef;
        }
      }
      return authInfo;
      // return login(username, password);
      // response.data['access_token'], response.data['refresh_token']);
    }
  }

  @override
  Future<AuthInfo> refreshToken(String token) async {
    final response = await httpClient.post("path", data: {
      "grant_type": "refresh_token",
      "refresh_token": token,
      "client_id": 2,
      "client_secret": "",
    });
    validateResponse(response.data);
    return response.data;
    // return AuthInfo(
    //     response.data['access_token'], response.data['refresh_token']);
  }

  @override
  Future<List<RegistergetsmstimeClass>> register(
      String phonenumber, String phoneId) async {
    final response = await httpClient.get(
      "Register/Time",
      // "Register/Tim",
      queryParameters: (<String, String>{
        "model": "register",
      }),
    );
    if (response.statusCode != 200) {
      // throw Exception('err');
      throw AppException();
    } else {
      final List<RegistergetsmstimeClass> time = [];
      if (response.data is List<dynamic>) {
        for (var element in (response.data as List<dynamic>)) {
          time.add(RegistergetsmstimeClass.fromJson(element));

          duration1.du2.value = time.first.model;

          putregisterrequest(duration1.du2.value, phonenumber, phoneId);
        }
      }

      return time;
    }
  }
}
