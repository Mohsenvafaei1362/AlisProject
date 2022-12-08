import 'package:local_notification_flutter_project/ui/data/ClassInfo/Partners_info.dart';
import 'package:dio/dio.dart';

abstract class IPartnersDataSource {
  Future<List<PartnersInfo>> partners();
}

class PartnersRemoteDataSource implements IPartnersDataSource {
  final Dio httpClient;

  PartnersRemoteDataSource(this.httpClient);
  @override
  Future<List<PartnersInfo>> partners() async {
    final response = await httpClient.get('path');
    final List<PartnersInfo> partners = [];
    for (var element in (response.data as List)) {
      partners.add(PartnersInfo.fromJson(element));
    }
    return partners;
  }
}
