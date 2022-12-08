import 'package:local_notification_flutter_project/ui/data/ClassInfo/roleInfo.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/role_data_source.dart';
import 'package:local_notification_flutter_project/ui/models/Dto/UserUpdateDto.dart';

final roleScreenRepository =
    RoleScreenRepository(RoleScreenRemoteDataSource(httpClient));

abstract class IRoleScreenRepository {
  Future<List<RoleInfo>> roleinfo(Ui_UserUpdateDto userUpdateDto);
}

class RoleScreenRepository implements IRoleScreenRepository {
  final RoleScreenRemoteDataSource dataSource;
  RoleScreenRepository(this.dataSource);
  @override
  Future<List<RoleInfo>> roleinfo(Ui_UserUpdateDto userUpdateDto) =>
      dataSource.role(userUpdateDto);
}
