import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/reciveCodeInfo.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/common/http_response_validator.dart';
import 'package:local_notification_flutter_project/ui/root.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/IdentificationCode/IdentificationCode.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final UiPhoneController phoneController = Get.put(UiPhoneController());
final UiLog log = Get.put(UiLog());
final UiRegisterReq registerReq = Get.put(UiRegisterReq());
final UiResiveCodeFrm resiveCodeFrm = Get.put(UiResiveCodeFrm());
final UiDl _dl = Get.put(UiDl());
final UiControlClickedSmsCode controlClick = Get.put(UiControlClickedSmsCode());

abstract class IReciveCodeDataSource {
  Future<List<ReciveCodeInfo>> code(int code);
}

class ReciveCodeRemoteDataSource
    with HttpResponseValidator
    implements IReciveCodeDataSource {
  late final Dio httpClient;
  ReciveCodeRemoteDataSource(this.httpClient);
  @override
  Future<List<ReciveCodeInfo>> code(int smsCode) async {
    final response = await httpClient.get(
      "Register",
      queryParameters: (<String, String>{
        "phonenumber": phoneController.phone.value,
        "phoneserial": log.id.value,
        "code": smsCode.toString(),
        "registerreqref": registerReq.registerreqid.value.toString(),
        "model": "register",
      }),
    );
    if (response.statusCode != 200) {
      throw AppException();
    } else {
      final List<ReciveCodeInfo> getregistersmsvalidation = [];
      // final List<ReciveCodeInfo> element=[];
      if (response.data is List<dynamic>) {
        if ((response.data as List<dynamic>).length == 1) {
          var element =
              ReciveCodeInfo.fromJson((response.data as List<dynamic>).first);
          print(element.runtimeType);
          getregistersmsvalidation.add(
              ReciveCodeInfo.fromJson((response.data as List<dynamic>).first));
          controlClick.controlSms.value = element.count;
          // print('time.first.count : ${element.count}');
        }
      }

      if (controlClick.controlSms.value != 0) {
        // await getdl();
        Get.to(
          () => Directionality(
            textDirection: TextDirection.rtl,
            child: RootScreen(),
          ),
        );
        // _dl.DlState == 2
        //     ? Get.snackbar(
        //         "?????? ?????? ?????? ???????? ?????? ?? ???????? ???? ?????????????? ???? ?????? ???????? ?????? ??????????",
        //         "",
        //         snackPosition: SnackPosition.TOP,
        //         duration: const Duration(
        //           milliseconds: 3000,
        //         ),
        //       )
        //     : Text('');
      } else {
        Get.snackbar(
          "???? ???????? ?????? ???????? ?????? ????????",
          "",
          snackPosition: SnackPosition.TOP,
          duration: const Duration(milliseconds: 1000),
        );
        Get.to(IdentificationCode(
          onChanged: (value) {},
        ));
      }

      return getregistersmsvalidation;
      // return AuthInfo('m', 'v');
    }
  }
}
