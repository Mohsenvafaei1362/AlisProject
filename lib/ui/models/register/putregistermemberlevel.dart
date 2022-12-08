import 'dart:convert';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/models/const/getconst.dart';
import 'package:get/get.dart';

final UiPhoneController phoneController = Get.put(UiPhoneController());
final UiLog log = Get.put(UiLog());
final UiRegisterReq registerReq = Get.put(UiRegisterReq());
final UiResiveCodeFrm resiveCodeFrm = Get.put(UiResiveCodeFrm());
final UiDl _dl = Get.put(UiDl());

class RegisterMemberLevel {
  final int RegisterMemberLevelId;

  RegisterMemberLevel(
    this.RegisterMemberLevelId,
  );
  RegisterMemberLevel.fromJson(Map json)
      : RegisterMemberLevelId = json['registerMemberLevelId'];
}

Future<List<RegisterMemberLevel>> putregistermemberlevel(int RegisterLevelRef,
    String RegisterLevelCode, String RegisterLvelTitle) async {
  final response = await httpClient.post(
    "Register/RegisterMemberLevel",
    data: jsonEncode(<String, String>{
      "CompanyRef": _dl.CompanyRef.value.toString(),
      "DlRef": _dl.DlId.value.toString(),
      "RegisterLevelRef": RegisterLevelRef.toString(),
      "CompanyTitle": _dl.Company.value.toString(),
      "DlFullName": _dl.FullName.value.toString(),
      "UserRef": _dl.UserId.value.toString(),
      "RegisterLevelCode": RegisterLevelCode,
      "RegisterLvelTitle": RegisterLvelTitle,
    }),
  );
  final List<RegisterMemberLevel> putRegisterMemberLevel = [];
  if (response.data is List<dynamic>) {
    if ((response.data as List<dynamic>).length == 1) {
      var element =
          RegisterMemberLevel.fromJson((response.data as List<dynamic>).first);
      _dl.RegisterMemberLevelId.value = element.RegisterMemberLevelId;
      _dl.RegisterLevelCode.value = RegisterLevelCode;
      _dl.RegisterLevelTitle.value = RegisterLvelTitle;
      switch (RegisterLvelTitle) {
        case 'IdentificationCode':
          getconst('IdentificationCode');
          break;
        case 'LoginThree':
          getconst('LoginThree');
          break;
        case 'Role':
          getconst('Role');
          break;
        case 'Map':
          getconst('Map');
          break;
        case 'LoginSix':
          getconst('LoginSix');
          break;
        case 'PreviewInfo':
          getconst('PreviewInfo');
          break;
        case 'Congratulation':
          getconst('Congratulation');
          break;
        case 'Confirmation':
          getconst('Confirmation');
          break;
        case 'Endfollowup':
          getconst('Endfollowup');
          break;

        default:
      }
    } else {
      print('object');
    }
  }
  return putRegisterMemberLevel;
}
