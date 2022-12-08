import 'package:local_notification_flutter_project/ui/data/ClassInfo/IdentificationCodeInfo.dart';
import 'package:dio/dio.dart';

abstract class IIdentificationCodeDataSource {
  Future<List<IdentificationCodeInfo>> identificationCode(String code);
}

class IdentificationCodeRemoteDataSource
    implements IIdentificationCodeDataSource {
  late final Dio httpClient;
  IdentificationCodeRemoteDataSource(this.httpClient);
  @override
  Future<List<IdentificationCodeInfo>> identificationCode(String code) async {
    final response = await httpClient.post('path', data: {
      "IdentificationCode": code,
    });
    final List<IdentificationCodeInfo> identificationCode = [];
    if (response.data is List<dynamic>) {
      if ((response.data as List<dynamic>).length == 1) {
        var element = IdentificationCodeInfo.fromJson(
            (response.data as List<dynamic>).first);
        identificationCode.add(IdentificationCodeInfo.fromJson(
            (response.data as List<dynamic>).first));
      }
    }
    return identificationCode;
  }
}
