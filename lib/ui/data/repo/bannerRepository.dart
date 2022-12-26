import 'package:local_notification_flutter_project/ui/data/ClassInfo/banner.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/sliderInfo.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/banner_remote_data_source.dart';

// final httpClient = Dio(BaseOptions(baseUrl: 'http://192.168.1.173:3000/'));

final bannerRepository = BannerRepository(BannerRemoteDataSource(httpClient));

abstract class IBannerRepository {
  Future<List<SliderInfo>> getAll(
      {required String model, required int modelid});
}

class BannerRepository implements IBannerRepository {
  final IBannerDataSource dataSource;

  BannerRepository(this.dataSource);

  @override
  Future<List<SliderInfo>> getAll(
      {required String model, required int modelid}) {
    return dataSource.getAll(model, modelid);
  }
}
