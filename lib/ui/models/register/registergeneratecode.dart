import 'dart:convert';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/GetSmsCode/get_sms_code.dart';
import 'package:get/get.dart';

final UiAddressIp getAddress2 = Get.put(UiAddressIp());
final UiLog log = Get.put(UiLog());
final UiPhoneController phoneController = Get.put(UiPhoneController());
var url1 = Uri.parse(getAddress2.Get_url('checkvalue'));

class RegistergeneratecodeClass {
  RegistergeneratecodeClass();
}

Future<List<RegistergeneratecodeClass>> getsmscode(
    int registerreqid, int tim, String phoneNumber, String phoneId) async {
  final response = await httpClient.post(
    "Register/1",
    data: jsonEncode(<String, String>{
      "phonenumber": phoneNumber,
      "phoneserial": phoneId,
      "model": "register",
      "seconds": tim.toString(),
      "registerreqref": registerreqid.toString(),
    }),
  );
  // if (response.statusCode != 200) {
  //   throw AppException();
  // } else {
  final List<RegistergeneratecodeClass> getsmscode = [];
  if (response.data is List<dynamic>) {
    Get.to(GetSmsCode(onChanged: (value) {}, timeout: 0));
    // Get.to(ReciveCode(
    //   onChanged: (value) {},
    //   timeout: 0,
    // ));
  }

  return getsmscode;
  // }

  // print(response.data);
}
