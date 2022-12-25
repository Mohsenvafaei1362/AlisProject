import 'package:dio/dio.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/race_info.dart';

abstract class IRaceRemoteDataSource {
  Future<List<RaceInfo>> race();
}

class RaceRemoteDataSource implements IRaceRemoteDataSource {
  final Dio httpClient;

  RaceRemoteDataSource(this.httpClient);
  @override
  Future<List<RaceInfo>> race() async {
    // final response = await httpClient.get('path');

    final List<RaceInfo> race = [];
    // (response.data as List).forEach((element) {
    //   race.add(RaceInfo.fromJson(element));
    // });
    return race;
  }
}
