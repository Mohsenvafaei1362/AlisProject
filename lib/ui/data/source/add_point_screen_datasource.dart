import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/add_point_screen_info.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/ValidationResponse.dart';

final UiDl _dl = Get.put(UiDl());

abstract class IAddPointScreenDataSource {
  Future<List<AddPointScreenInfo>> getPoint(
      String title,
      double lat,
      double long,
      String image,
      int RegisterLevelRef,
      String RegisterLevelCode,
      String RegisterLvelTitle);
}

class AddPointScreenRemoteDataSource implements IAddPointScreenDataSource {
  final Dio httpClient;

  AddPointScreenRemoteDataSource(this.httpClient);
  @override
  Future<List<AddPointScreenInfo>> getPoint(
    String title,
    double lat,
    double long,
    String image,
    int RegisterLevelRef,
    String RegisterLevelCode,
    String RegisterLvelTitle,
  ) async {
    final response = await httpClient.post('Loc', data: {
      'LocText': title,
      'Lat': lat,
      'Lan': long,
      'Pic': image,
      'DlRef': _dl.DlId.value,
      'UserRef': _dl.UserId.value,
    });
    // validateResponse(response);
    final List<AddPointScreenInfo> getpoint = [];
    if (response.data is List<dynamic>) {
      for (var element in (response.data as List<dynamic>)) {
        getpoint.add(AddPointScreenInfo.fromJson(element));
      }
    }
    // putregistermemberlevel(4, '4', 'LoginSex');
    return getpoint;
  }
}
