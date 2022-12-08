import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/change_password_data_source.dart';

final changePasswordRepository =
    ChangePasswordRepository(ChangePasswordRemoteDataSource(httpClient));

abstract class IChangePasswordRepository {
  Future<void> pass(int oldpass, int newpass);
}

class ChangePasswordRepository implements IChangePasswordRepository {
  final IChangePasswordDataSource dataSource;

  ChangePasswordRepository(this.dataSource);
  @override
  Future<void> pass(int oldpass, int newpass) =>
      dataSource.pass(oldpass, newpass);
}
