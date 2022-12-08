import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/models/register/registerrequest.dart';
import 'package:get/get.dart';

final UiAddressIp getAddress2 = Get.put(UiAddressIp());
var url = Uri.parse(getAddress2.Get_url('checkmadarek'));
final UiDuration1 duration1 = Get.put(UiDuration1());

class RegistergetsmstimeClass {
  final int model;

  RegistergetsmstimeClass(
    this.model,
  );
  RegistergetsmstimeClass.fromJson(Map json) : model = json['smstime'];
}

Future<List<RegistergetsmstimeClass>> getTime(
    String PhoneNumber, String phoneId) async {
  final response = await httpClient.get(
    "Register/Time",
    queryParameters: (<String, String>{
      "model": "register",
    }),
  );
  if (response.statusCode != 200) {
    throw AppException();
  } else {
    final List<RegistergetsmstimeClass> time = [];
    if (response.data is List<dynamic>) {
      for (var element in (response.data as List<dynamic>)) {
        time.add(RegistergetsmstimeClass.fromJson(element));
        duration1.du2.value = time.first.model;

        putregisterrequest(duration1.du2.value, PhoneNumber, phoneId);
      }
    }

    return time;
  }

  // print(response.data);
}
