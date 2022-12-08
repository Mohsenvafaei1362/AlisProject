import 'dart:convert';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:get/get.dart';

final UiPhoneController getinfo = Get.put(UiPhoneController());

class PutUserInfo {
  final int UserRef;
  PutUserInfo(
    this.UserRef,
  );
  PutUserInfo.fromJson(Map json) : UserRef = json['UserRef'];
}

Future<List<PutUserInfo>> putuserinfo(
    String Fname,
    String Lname,
    String NationalCode,
    String Email,
    String PhoneNumber,
    String Eparchy,
    String City,
    int PostalCode,
    int UserRef) async {
  final response = await httpClient.post(
    "insertDL",
    data: jsonEncode(<String, String>{
      "Fname": Fname,
      "Lname": Lname,
      "NationalCode": NationalCode.toString(),
      "Email": Email,
      "PhoneNumber": PhoneNumber,
      "Eparchy": Eparchy,
      "City": City,
      "PostalCode": PostalCode.toString(),
      "UserRef": UserRef.toString(),
    }),
  );

  if (response.statusCode != 200) {
    throw AppException();
  } else {
    final List<PutUserInfo> putuserinfo = [];
    if (response.data is List<dynamic>) {
      if ((response.data as List<dynamic>).length == 1) {
        var element =
            PutUserInfo.fromJson((response.data as List<dynamic>).first);
        // _dl.UserId.value = element.UserRef;
      } else {
        print('object');
      }
    }
    return putuserinfo;
  }
}
