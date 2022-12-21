import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/banner.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/sliderInfo.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:dio/dio.dart';

final UserInfo _userInfo = Get.put(UserInfo());

abstract class IBannerDataSource {
  Future<List<SliderInfo>> getAll();
}

class BannerRemoteDataSource extends IBannerDataSource {
  late final Dio httpClient;
  BannerRemoteDataSource(this.httpClient);

  @override
  Future<List<SliderInfo>> getAll() async {
    final response = await httpClient.get('Slider', queryParameters: {
      "SliderGroupName": 'Main',
      "UserRef": _userInfo.UserId.value,
      "UsersGroupRef": _userInfo.userGroups.value,
      "sellsCenterRef": _userInfo.sellsCenter.value,
    });
    if (response.statusCode != 200) {
      throw AppException();
    } else {
      final List<SliderInfo> getImage = [];
      for (var element in (response.data as List<dynamic>)) {
        getImage.add(SliderInfo.fromJson(element));
      }
      return getImage;
    }

    // final response = await httpProduct.get('slider');
    // // final response = await httpClient.get('http://185.135.229.96:806/slider');
    // // validateResponse(response.data);
    // final List<UiBannerEntity> banners = [];
    // (response.data as List).forEach((jsonObject) {
    //   banners.add(UiBannerEntity.fromJson(jsonObject));
    // });
    // return banners;
  }
}
