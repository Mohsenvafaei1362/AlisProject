import 'package:local_notification_flutter_project/ui/data/ClassInfo/banner.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:dio/dio.dart';

abstract class IBannerDataSource {
  Future<List<UiBannerEntity>> getAll();
}

class BannerRemoteDataSource extends IBannerDataSource {
  late final Dio httpClient;
  BannerRemoteDataSource(this.httpClient);

  @override
  Future<List<UiBannerEntity>> getAll() async {
    final response = await httpProduct.get('slider');
    // final response = await httpClient.get('http://185.135.229.96:806/slider');
    // validateResponse(response.data);
    final List<UiBannerEntity> banners = [];
    (response.data as List).forEach((jsonObject) {
      banners.add(UiBannerEntity.fromJson(jsonObject));
    });
    return banners;
  }
}
