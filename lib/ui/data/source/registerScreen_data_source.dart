import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/register.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/models/register/registergetsmstime.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

final UiLog log = Get.put(UiLog());

abstract class IRegisterScreenDataSource {
  Future<List<RegisterScreenInfo>> getPhone(int phone, String phoneId);
}

class RegisterScreenRemoteDataSource implements IRegisterScreenDataSource {
  late final Dio httpClient;
  RegisterScreenRemoteDataSource(this.httpClient);
  @override
  Future<List<RegisterScreenInfo>> getPhone(int phone, String phoneId) async {
    final response = await httpClient.post(
      'RegisterSmsCodeClear',
      data: {
        "phonenumber": phone,
        "phoneserial": phoneId,
        "model": "register",
      },
    );

    // validateResponse(response.data);
    if (response.statusCode != 200) {
      throw AppException();
    } else {
      getTime(phone.toString(), phoneId);
      return response.data;
      // return AuthInfo('m', 'v');
      // response.data['access_token'], response.data['refresh_token']);
    }
    // final response = await httpClient.post(
    //   'RegisterSmsCodeClear',
    //   data: {
    //     "phonenumber": phone,
    //     "phoneserial": log.id.value,
    //     "model": "register",
    //   },
    // );
    // final List<RegisterScreenInfo> registerScreen = [];
    // for (var element in response.data) {
    //   registerScreen.add(element);
    // }
    // // if (response.statusCode != 200) {
    // //   throw AppException();
    // // } else {
    // getTime();
    // return registerScreen;
    // // response.data['access_token'], response.data['refresh_token']);
    // // }
  }
}
