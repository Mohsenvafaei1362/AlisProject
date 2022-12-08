import 'package:local_notification_flutter_project/ui/data/ClassInfo/register.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/registerScreen_data_source.dart';

final registerScreenRepository =
    RegisterScreenRepository(RegisterScreenRemoteDataSource(httpClient));

abstract class IRegisterScreenRepository {
  Future<List<RegisterScreenInfo>> getPhone(int phone, String phoneId);
}

class RegisterScreenRepository implements IRegisterScreenRepository {
  late final RegisterScreenRemoteDataSource dataSource;
  RegisterScreenRepository(this.dataSource);
  @override
  Future<List<RegisterScreenInfo>> getPhone(int phone, String phoneId) =>
      dataSource.getPhone(phone, phoneId);
}
