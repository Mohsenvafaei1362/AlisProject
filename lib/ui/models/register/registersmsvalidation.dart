import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:get/get.dart';

final UiPhoneController phoneController = Get.put(UiPhoneController());
final UiLog log = Get.put(UiLog());
final UiRegisterReq registerReq = Get.put(UiRegisterReq());
final UiResiveCodeFrm resiveCodeFrm = Get.put(UiResiveCodeFrm());
final UiControlClickedSmsCode controlClick = Get.put(UiControlClickedSmsCode());

class RegisterSmsData {
  final int count;

  RegisterSmsData(
    this.count,
  );
  RegisterSmsData.fromJson(Map json) : count = json['count'];
}

Future<List<RegisterSmsData>> getregistersmsvalidation(String code) async {
  final response = await httpClient.get(
    "Register",
    queryParameters: (<String, String>{
      "phonenumber": phoneController.phone.value,
      "phoneserial": log.id.value,
      "code": code,
      "registerreqref": registerReq.registerreqid.value.toString(),
      "model": "register",
    }),
  );
  // if (response.statusCode != 200) {
  //   throw AppException();
  // } else {
  final List<RegisterSmsData> getregistersmsvalidation = [];
  if (response.data is List<dynamic>) {
    if ((response.data as List<dynamic>).length == 1) {
      var element =
          RegisterSmsData.fromJson((response.data as List<dynamic>).first);
      getregistersmsvalidation.add(
          RegisterSmsData.fromJson((response.data as List<dynamic>).first));
      controlClick.controlSms.value = element.count;
      // print('time.first.count : ${element.count}');
    }
  }

  return getregistersmsvalidation;
  // }
}
