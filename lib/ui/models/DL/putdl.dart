import 'dart:convert';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:get/get.dart';

final UiPhoneController phoneController = Get.put(UiPhoneController());
final UiLog log = Get.put(UiLog());
final UiRegisterReq registerReq = Get.put(UiRegisterReq());
final UiResiveCodeFrm resiveCodeFrm = Get.put(UiResiveCodeFrm());
final UiDl _dl = Get.put(UiDl());

class PutDl {
  final int DlId;

  PutDl(
    this.DlId,
  );
  PutDl.fromJson(Map json) : DlId = json['dlId'];
}

Future<List<PutDl>> putdl() async {
  final response = await httpClient.post(
    "Dl",
    data: jsonEncode(<String, String>{
      "CompanyRef": '1',
      "PhoneNumber": phoneController.phone.value,
      "CompanyTitle": 'هلدینگ عالیس',
      "DlCode": '-1',
      "DlId": '-1',
      "Email": '',
      "FName": '',
      "LName": '',
      "FullName": '',
      "NationalCode": '',
      "DlState": '1',
      "Creator": '-1',
      "ReferalCode": phoneController.moaref.value,

      // "phoneserial": log.id.value,
      // "code": code,
      // "registerreqref": registerReq.registerreqid.value.toString(),
      // "model": "register",
    }),
  );
  final List<PutDl> putdl = [];
  if (response.data is List<dynamic>) {
    if ((response.data as List<dynamic>).length == 1) {
      var element = PutDl.fromJson((response.data as List<dynamic>).first);
      _dl.DlId.value = element.DlId;
      _dl.Company.value = 'هلدینگ عالیس';
      _dl.CompanyRef.value = 1;
      _dl.DlCode.value = '-1';
      _dl.Email.value = '';
      _dl.FName.value = '';
      _dl.LName.value = '';
      _dl.UserId.value = -1;
      _dl.UserName.value = '-1';
      _dl.FullName.value = '';
      _dl.NastinalCode.value = '';
      _dl.PhoneNumber.value = phoneController.phone.value;
      _dl.DlState = 1;

      // putuser(_dl.UserName.value, '-1', element.DlId, 'LoginThree');

      // for (var element in (response.data as List<dynamic>)) {
      //   time.add(GetDl.fromJson(element));
      // }
    } else {
      print('object');
    }
  }
  return putdl;
}
