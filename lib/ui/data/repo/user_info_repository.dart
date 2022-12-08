import 'package:local_notification_flutter_project/ui/data/ClassInfo/User_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/user_info_data_source.dart';

final userInfoRepository =
    UserInfoRepository(UserInfoRemoteDataSource(httpClient));

abstract class IUserInfoRepository {
  Future<List<UserInfo>> userInfo();
}

class UserInfoRepository implements IUserInfoRepository {
  final IUserInfoDataSource dataSource;

  UserInfoRepository(this.dataSource);
  @override
  Future<List<UserInfo>> userInfo() => dataSource.userInfo();
}
