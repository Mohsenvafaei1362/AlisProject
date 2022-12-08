import 'dart:convert';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/models/register/putregistermemberlevel.dart';
import 'package:get/get.dart';

final UiDl _dl = Get.put(UiDl());

class PutUser {
  final int UserId;
  PutUser(
    this.UserId,
  );
  PutUser.fromJson(Map json) : UserId = json['userId'];
}

Future<List<PutUser>> putuser(String UserName, String Pass, int DlRef) async {
  final response = await httpClient.post(
    "User",
    data: jsonEncode(<String, String>{
      "UserName": UserName,
      "Pass": Pass,
      "DlRef": DlRef.toString(),
    }),
  );
  final List<PutUser> putuser = [];
  if (response.data is List<dynamic>) {
    if ((response.data as List<dynamic>).length == 1) {
      var element = PutUser.fromJson((response.data as List<dynamic>).first);
      _dl.UserId.value = element.UserId;
      switch ('') {
        // case 'LoginThree':

        //   // putregistermemberlevel(1, '1', 'LoginThree');
        //   break;
        // default:
      }
    } else {
      print('object');
    }
  }
  return putuser;
}
