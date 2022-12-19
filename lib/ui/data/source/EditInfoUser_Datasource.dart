import 'package:dio/dio.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/ValidationResponse.dart';

abstract class IEditInfoUserDataSource {
  Future<void> edit(
    String fname,
    String lname,
    String email,
    String phone,
  );
}

class EditInfoUserRemoteDataSource implements IEditInfoUserDataSource {
  final Dio httpClient;

  EditInfoUserRemoteDataSource(this.httpClient);
  @override
  Future<void> edit(
      String fname, String lname, String email, String phone) async {
    final response = await httpClient.post(
      'path',
      data: {
        "fname": fname,
        "lname": lname,
        "email": email,
        "phone": phone,
      },
    );
    validateResponse(response);
  }
}
