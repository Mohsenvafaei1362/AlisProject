import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/sliderInfo.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/ValidationResponse.dart';

final UserInfo _userInfo = Get.put(UserInfo());

abstract class ISliderDataSource {
  ///get image slider:[link]
  Future<List<SliderInfo>> getImage(String sliderGroup); //abstract method
}

class SliderRemoteDataSource implements ISliderDataSource {
  final Dio httpClient;
  SliderRemoteDataSource(this.httpClient);
  @override
  Future<List<SliderInfo>> getImage(String sliderGroup) async {
    final response = await httpClient.get('Slider', queryParameters: {
      "SliderGroupName": sliderGroup,
      "UserRef": _userInfo.UserId.value,
      "UsersGroupRef": _userInfo.userGroups.value,
      "sellsCenterRef": _userInfo.sellsCenter.value,
    });
    validateResponse(response);
    final List<SliderInfo> getImage = [];
    for (var element in (response.data as List<dynamic>)) {
      getImage.add(SliderInfo.fromJson(element));
    }
    return getImage;
  }
}
