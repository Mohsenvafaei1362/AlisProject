import 'dart:io';

import 'package:local_notification_flutter_project/ui/data/ClassInfo/add_point_screen_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/add_point_screen_datasource.dart';

final addPointScreenRepository =
    AddPointScreenRepository(AddPointScreenRemoteDataSource(httpClient));

abstract class IAddPointScreenRepository {
  Future<List<AddPointScreenInfo>> getPoint(
      String title,
      double lat,
      double long,
      String image,
      int RegisterLevelRef,
      String RegisterLevelCode,
      String RegisterLvelTitle);
}

class AddPointScreenRepository implements IAddPointScreenRepository {
  final IAddPointScreenDataSource dataSource;

  AddPointScreenRepository(this.dataSource);

  @override
  Future<List<AddPointScreenInfo>> getPoint(
          String title,
          double lat,
          double long,
          String image,
          int RegisterLevelRef,
          String RegisterLevelCode,
          String RegisterLvelTitle) =>
      dataSource.getPoint(title, lat, long, image, RegisterLevelRef,
          RegisterLevelCode, RegisterLvelTitle);
}
