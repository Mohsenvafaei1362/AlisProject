import 'package:local_notification_flutter_project/ui/data/ClassInfo/ChangePassword_info.dart';
import 'package:dio/dio.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/ValidationResponse.dart';

abstract class IChangePasswordDataSource {
  Future<ChangePasswordInfo> pass(int oldpass, int newpass);
}

class ChangePasswordRemoteDataSource implements IChangePasswordDataSource {
  final Dio httpClient;

  ChangePasswordRemoteDataSource(this.httpClient);
  @override
  Future<ChangePasswordInfo> pass(int oldpass, int newpass) async {
    final response = await httpClient.put('path', data: {
      'oldpass': oldpass,
      'newpass': newpass,
    });
// validateResponse(response);
    return response.data['pass'];
  }
}
