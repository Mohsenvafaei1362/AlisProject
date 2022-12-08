import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/Club_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

final UiDl _dl = Get.put(UiDl());
final Club _club = Get.put(Club());
final UserInfo _userInfo = Get.put(UserInfo());

abstract class IClubDataSource {
  Future<List<ClubInfo>> club();
}

class ClubRemoteDataSource implements IClubDataSource {
  final Dio httpClient;

  ClubRemoteDataSource(this.httpClient);
  @override
  Future<List<ClubInfo>> club() async {
    final response = await httpClient.get('Club', queryParameters: {
      "UserRef": _dl.UserId.value,
      "DlRef": _dl.DlId.value,
      "RoleRef": _userInfo.RoleId.value,
    });
    if (response.statusCode != 200) {
      throw AppException();
    } else {
      final List<ClubInfo> club = [];
      if ((response.data as List<dynamic>).length == 1) {
        var element = ClubInfo.fromJson((response.data as List<dynamic>).first);
        _club.value.value = element.Value;
        club.add(element);
      }
      return club;
    }

    // final List<ClubInfo> club = [];
    // for (var element in (response.data as List)) {
    //   club.add(ClubInfo.fromJson(element));
    // }
    // return club;
  }
}
