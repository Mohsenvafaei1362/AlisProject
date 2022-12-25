import 'package:dio/dio.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/festival.dart';

abstract class IFestivalDataSource {
  Future<List<FestivalInfo>> festival();
}

class FestivalRemoteDataSource implements IFestivalDataSource {
  final Dio httpClient;

  FestivalRemoteDataSource(this.httpClient);
  @override
  Future<List<FestivalInfo>> festival() async {
    // final response = await httpClient.get('path');

    final List<FestivalInfo> festival = [];
    // (response.data as List).forEach((element) {
    //   festival.add(FestivalInfo.fromJson(element));
    // });
    return festival;
  }
}
