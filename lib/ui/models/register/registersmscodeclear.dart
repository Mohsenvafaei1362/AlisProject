import 'dart:convert';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/models/register/registergetsmstime.dart';
import 'package:get/get.dart';

final UiPhoneController phoneController = Get.put(UiPhoneController());
final UiLog log = Get.put(UiLog());

class Timedata {
  final bool del;

  Timedata(
    this.del,
  );
  Timedata.fromJson(Map json) : del = json['del'];
  //  response.data['access_token'], response.data['refresh_token']);
}

Future<List<Timedata>> putregistersmsreq() async {
  final response = await httpClient.post(
    "RegisterSmsCodeClear",
    data: jsonEncode(<String, String>{
      "phonenumber": phoneController.phone.value,
      "phoneserial": log.id.value,
      "model": "register",
      // "clientsecret":'',
    }),
  );

  final List<Timedata> putregistersmsreq = [];
  if (response.data is List<dynamic>) {
    for (var element in (response.data as List<dynamic>)) {
      putregistersmsreq.add(Timedata.fromJson(element));
      // duration1.du2.value = time.first.cleared;
      getTime(phoneController.phone.value, log.id.value);
    }
  }

  return putregistersmsreq;
  // print(response.data);
}
