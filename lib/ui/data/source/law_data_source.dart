import 'dart:convert';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/lawInfo.dart';
import 'package:local_notification_flutter_project/ui/models/const/getconst.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

final UiPhoneController phoneController = Get.put(UiPhoneController());
final UiLog log = Get.put(UiLog());
final UiRegisterReq registerReq = Get.put(UiRegisterReq());
final UiResiveCodeFrm resiveCodeFrm = Get.put(UiResiveCodeFrm());
final UiDl _dl = Get.put(UiDl());

abstract class ILawDataSource {
  Future<List<LowInfo>> law(
      int RegisterLevelRef, String RegisterLevelCode, String RegisterLvelTitle);
}

class LawScreenRemoteDataSource implements ILawDataSource {
  final Dio httpClient;
  LawScreenRemoteDataSource(this.httpClient);
  @override
  Future<List<LowInfo>> law(int RegisterLevelRef, String RegisterLevelCode,
      String RegisterLvelTitle) async {
    final response = await httpClient.post(
      "Register/RegisterMemberLevel",
      data: jsonEncode(<String, String>{
        "CompanyRef": _dl.CompanyRef.value.toString(),
        "DlRef": _dl.DlId.value.toString(),
        "RegisterLevelRef": RegisterLevelRef.toString(),
        "CompanyTitle": _dl.Company.value.toString(),
        "DlFullName": _dl.FullName.value.toString(),
        "UserRf": _dl.UserId.value.toString(),
        "RegisterLevelCode": RegisterLevelCode,
        "RegisterLvelTitle": RegisterLvelTitle,
      }),
    );
    final List<LowInfo> putRegisterMemberLevel = [];
    if (response.data is List<dynamic>) {
      if ((response.data as List<dynamic>).length == 1) {
        var element = LowInfo.fromJson((response.data as List<dynamic>).first);
        _dl.RegisterMemberLevelId.value = element.RegisterMemberLevelId;
        _dl.RegisterLevelCode.value = RegisterLevelCode;
        _dl.RegisterLevelTitle.value = RegisterLvelTitle;
        switch (RegisterLvelTitle) {
          case 'LoginThree':
            getconst('LoginThree');
            break;
          case 'Loginfour':
            getconst('Loginfour');
            break;
          case 'Loginfive':
            getconst('Loginfive');
            break;
          case 'LoginSix':
            getconst('LoginSix');
            break;

          default:
        }
      } else {
        print('object');
      }
    }
    return putRegisterMemberLevel;
  }
}
