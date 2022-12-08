import 'dart:convert';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/models/register/registergeneratecode.dart';
import 'package:get/get.dart';

final UiPhoneController phoneController = Get.put(UiPhoneController());
final UiLog log = Get.put(UiLog());
final UiRegisterReq registerReq = Get.put(UiRegisterReq());

class Timedata {
  final int registerreqid;

  Timedata(
    this.registerreqid,
  );
  Timedata.fromJson(Map json) : registerreqid = json['registerreqid'];
}

Future<List<Timedata>> putregisterrequest(
    int tim, String phoneNUmber, String phoneId) async {
  final response = await httpClient.post(
    "Register",
    data: jsonEncode(<String, String>{
      "phonenumber": phoneNUmber,
      "phoneserial": phoneId,
      "phonebrand": log.brand.value,
      "phonemodel": log.model.value,
      "model": "register",
    }),
  );
  // if (response.statusCode != 200) {
  //   throw AppException();
  // } else {
  final List<Timedata> time = [];
  if (response.data is List<dynamic>) {
    for (var element in (response.data as List<dynamic>)) {
      time.add(Timedata.fromJson(element));
      registerReq.registerreqid.value = time.first.registerreqid;
      getsmscode(time.first.registerreqid, tim, phoneNUmber, phoneId);
    }
  }

  return time;
  // }

  // print(response.data);
}
