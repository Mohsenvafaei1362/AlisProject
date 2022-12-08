import 'dart:convert';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/roleInfo.dart';
import 'package:local_notification_flutter_project/ui/models/Dto/UserUpdateDto.dart';
import 'package:local_notification_flutter_project/ui/models/user/userUpdate.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

final UiPhoneController getinfo = Get.put(UiPhoneController());
final UiDl _dl = Get.put(UiDl());

abstract class IRoleDataSource {
  Future<List<RoleInfo>> role(Ui_UserUpdateDto userUpdateDto);
}

class RoleScreenRemoteDataSource implements IRoleDataSource {
  final Dio httpClient;
  RoleScreenRemoteDataSource(this.httpClient);
  @override
  Future<List<RoleInfo>> role(Ui_UserUpdateDto userUpdateDto) async {
    final response = await httpClient.put(
      "User",
      data: jsonEncode(<String, String>{
        "UserId": _dl.UserId.value.toString(),
        "RoleTitleEn": userUpdateDto.RoleTitleEn,
      }),
    );

    // if (response.statusCode != 200) {
    //   throw AppException();
    // } else {
    final List<RoleInfo> userupdate = [];
    if (response.data is List<dynamic>) {
      if ((response.data as List<dynamic>).length == 1) {
        var element =
            UserUpdate.fromJson((response.data as List<dynamic>).first);
      } else {
        print('object');
      }
    }
    return userupdate;
  }
}
