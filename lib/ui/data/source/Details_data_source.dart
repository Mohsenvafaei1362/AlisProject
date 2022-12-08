import 'package:local_notification_flutter_project/ui/data/ClassInfo/Details_info.dart';
import 'package:dio/dio.dart';

abstract class IDetailsDataSource {
  Future<List<DetailsInfo>> details();
}

class DetailsRemoteDataSource implements IDetailsDataSource {
  final Dio httpClient;

  DetailsRemoteDataSource(this.httpClient);
  @override
  Future<List<DetailsInfo>> details() async {
    final response = await httpClient.get('path');

    final List<DetailsInfo> detail = [];
    for (var element in (response.data as List)) {
      detail.add(DetailsInfo.fromJson(element));
    }
    return detail;
  }
}
