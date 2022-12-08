import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/Ghole_info.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

final UiDl _dl = Get.put(UiDl());
final Club _club = Get.put(Club());
final UserInfo _userInfo = Get.put(UserInfo());

abstract class IGholeDataSource {
  Future<List<GholeInfo>> ghole();
}

class GholeRemoteDataSource implements IGholeDataSource {
  final Dio httpClient;

  GholeRemoteDataSource(this.httpClient);
  @override
  Future<List<GholeInfo>> ghole() async {
    final response = await httpClient.get('Level', queryParameters: {
      "RoleRef": _userInfo.RoleId.value,
      "Value": _club.value.value,
    });
    final List<GholeInfo> ghole = [];
    if ((response.data as List<dynamic>).length == 1) {
      for (var element in (response.data as List)) {
        ghole.add(GholeInfo.fromJson(element));
      }
    }
    return ghole;
  }
}
