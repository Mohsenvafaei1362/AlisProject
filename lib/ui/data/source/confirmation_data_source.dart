import 'package:local_notification_flutter_project/ui/data/ClassInfo/confirmationInfo.dart';
import 'package:dio/dio.dart';

abstract class IConfirmationDataSource {
  Future<List<ConfirmationInfo>> confirmationState();
}

class ConfirmationRemoteDataSource implements IConfirmationDataSource {
  final Dio httpClient;
  ConfirmationRemoteDataSource(this.httpClient);
  @override
  Future<List<ConfirmationInfo>> confirmationState() async {
    final response = await httpClient.get('confirmation');
    final List<ConfirmationInfo> products = [];
    // validateResponse(response);
    for (var element in (response.data as List<dynamic>)) {
      products.add(ConfirmationInfo.fromJson(element));
    }
    return products;
  }
}
