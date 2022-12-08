import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Confirmation/confirmation.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Congratulation/congratulation.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Documents/documents.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/EndRegister/endRegister.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/IdentificationCode/IdentificationCode.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Law/law.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/screens/add_point_screen.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/PreviewInfo/previewInfo.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Role/role.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final UiPhoneController phoneController = Get.put(UiPhoneController());
final UiLog log = Get.put(UiLog());
final UiRegisterReq registerReq = Get.put(UiRegisterReq());
final UiResiveCodeFrm resiveCodeFrm = Get.put(UiResiveCodeFrm());
final UiConst _Const = Get.put(UiConst());
final UiDl _dl = Get.put(UiDl());

class GetConst {
  final int constid;
  final String ConstModelCode, ConstModelTitle, ConstTitle, ConstDesc;
  GetConst(
    this.constid,
    this.ConstModelCode,
    this.ConstModelTitle,
    this.ConstTitle,
    this.ConstDesc,
  );
  GetConst.fromJson(Map json)
      : constid = json['constId'],
        ConstModelTitle = json['constModelTitle'],
        ConstTitle = json['constTitle'],
        ConstDesc = json['constDesc'],
        ConstModelCode = json['constModelCode'];
}

Future<List<GetConst>> getconst(String constmodel) async {
  final response = await httpClient.get(
    "Const",
    queryParameters: (<String, String>{
      "ConstModel": constmodel,
    }),
  );
  // if (response.statusCode != 200) {
  //   throw AppException();
  // } else {
  final List<GetConst> putRegisterMemberLevel = [];
  if (response.data is List<dynamic>) {
    if ((response.data as List<dynamic>).length == 1) {
      var element = GetConst.fromJson((response.data as List<dynamic>).first);
      _Const.ConstId.value = element.constid;
      _Const.ConstDesc.value = element.ConstDesc;
      _Const.ConstModelCode.value = element.ConstModelCode;
      _Const.ConstModelTitle.value = element.ConstModelTitle;
      _Const.ConstTitle.value = element.ConstTitle;
      _dl.DlId.value = _dl.DlId.value;
      switch (constmodel) {
        case 'IdentificationCode':
          Get.to(IdentificationCode(onChanged: (value) {}));
          break;
        case 'LoginThree':
          Get.to(const Directionality(
              textDirection: TextDirection.rtl, child: Law()));
          break;
        case 'Role':
          Get.to(() => const Role());
          break;
        case 'Map':
          Get.to(const Ui_AddPointScreen());
          break;
        case 'LoginSix':
          Get.to(const Documents());
          break;
        case 'PreviewInfo':
          Get.to(const PreviewInfo());
          break;
        case 'Congratulation':
          Get.to(const Congratulation());
          break;
        case 'Confirmation':
          Get.to(Confirmation());
          break;
        case 'Endfollowup':
          Get.to(EndRegister());
          break;

        default:
      }
    } else {
      print('object');
    }
  }
  return putRegisterMemberLevel;
  // }
}
