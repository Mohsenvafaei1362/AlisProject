import 'dart:convert';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/models/Dto/EditDlDto.dart';
import 'package:get/get.dart';

final UiPhoneController phoneController = Get.put(UiPhoneController());
final UiLog log = Get.put(UiLog());
final UiRegisterReq registerReq = Get.put(UiRegisterReq());
final UiResiveCodeFrm resiveCodeFrm = Get.put(UiResiveCodeFrm());
final UiDl _dl = Get.put(UiDl());

class editDl {
  final int DlId;

  editDl(
    this.DlId,
  );
  editDl.fromJson(Map json) : DlId = json['dlId'];
}

Future<List<EditDlDto>> EditDl(EditDlDto editDlDto) async {
  final response = await httpClient.put(
    "Dl",
    data: jsonEncode(<String, String>{
      "CompanyRef": '1',
      "PhoneNumber": phoneController.phone.value,
      "CompanyTitle": 'هلدینگ عالیس',
      "DlCode": '-1',
      "DlId": _dl.DlId.value.toString(),
      "Email": editDlDto.Email,
      "FName": editDlDto.FName,
      "LName": editDlDto.LName,
      "FullName": editDlDto.FName + editDlDto.LName,
      "NationalCode": editDlDto.NationalCode.toString(),
      "EparchyRef": editDlDto.EparchyRef.toString(),
      "EparchyName": editDlDto.EparchyName,
      "CityRef": editDlDto.CityRef.toString(),
      "CityName": editDlDto.CityName,
      "PostalCode": editDlDto.PostalCode.toString(),
      "DlState": '1',
      "Creator": '-1',
    }),
  );
  if (response.statusCode != 200) {
    throw AppException();
  } else {
    final List<EditDlDto> editdl = [];
    if (response.data is List<dynamic>) {
      if ((response.data as List<dynamic>).length == 1) {
        var item = editDl.fromJson((response.data as List<dynamic>).first);
        // var element = EditDlDto.fromJson((response.data as List<dynamic>).first);

      } else {
        print('object');
      }
    }
    return editdl;
  }
}
