import 'package:local_notification_flutter_project/ui/data/ClassInfo/topPepole.dart';
import 'package:dio/dio.dart';

abstract class ITopPepoleDataSource {
  Future<List<TopPepoleInfo>> topPepoleInfo();
}

class TopPepoleRemoteDataSource implements ITopPepoleDataSource {
  late final Dio httpClient;
  TopPepoleRemoteDataSource(this.httpClient);
  @override
  Future<List<TopPepoleInfo>> topPepoleInfo() async {
    // final response = await httpClient.get('path');
    final List<TopPepoleInfo> topPepole = [];
    // (response.data as List).forEach((element) {
    //   topPepole.add(TopPepoleInfo.fromJson(element));
    // });
    return topPepole;
  }
}
