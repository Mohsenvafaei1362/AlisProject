import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/EditInfoUser_Datasource.dart';

final editInfoUserRepository =
    EditInfoUserRepository(EditInfoUserRemoteDataSource(httpClient));

abstract class IEditInfoUserRepository {
  Future<void> edit(
    String fname,
    String lname,
    String email,
    String phone,
  );
}

class EditInfoUserRepository implements IEditInfoUserRepository {
  final IEditInfoUserDataSource dataSource;

  EditInfoUserRepository(this.dataSource);
  @override
  Future<void> edit(String fname, String lname, String email, String phone) {
    return dataSource.edit(fname, lname, email, phone);
  }
}
