import 'dart:convert';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/models/Dto/UserUpdateDto.dart';
import 'package:get/get.dart';

final UiPhoneController getinfo = Get.put(UiPhoneController());
final UiDl _dl = Get.put(UiDl());

class UserUpdate {
  final bool created;
  UserUpdate(
    this.created,
  );
  UserUpdate.fromJson(Map json) : created = json['created'];
}

Future<List<Ui_UserUpdateDto>> userUpdate(
    Ui_UserUpdateDto userUpdateDto) async {
  final response = await httpClient.put(
    "User",
    data: jsonEncode(<String, String>{
      "UserId": _dl.UserId.value.toString(),
      "RoleTitleEn": userUpdateDto.RoleTitleEn,
      "Fname": '',
      "LName": '',
      "Email": '',
      "Natinalcode": '',
      "OstanId": '',
      "CityId": '',
      "PostalCode": '',
      "CityName": '',
      "OstanNAme": '',
    }),
  );

  // if (response.statusCode != 200) {
  //   throw AppException();
  // } else {
  final List<Ui_UserUpdateDto> userupdate = [];
  if (response.data is List<dynamic>) {
    if ((response.data as List<dynamic>).length == 1) {
      var item = UserUpdate.fromJson((response.data as List<dynamic>).first);
    } else {
      print('object');
    }
  }
  return userupdate;
}
