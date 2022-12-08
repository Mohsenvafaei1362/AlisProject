import 'package:local_notification_flutter_project/ui/data/ClassInfo/reciveCodeInfo.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';

import '../source/recivecode_login_data_source.dart';

final reciveCodeRepository =
    ReciveCodeRepository(ReciveCodeRemoteDataSource(httpClient));

abstract class IReciveCodeRepository {
  Future<List<ReciveCodeInfo>> Code(int smsCode);
}

class ReciveCodeRepository implements IReciveCodeRepository {
  late final IReciveCodeDataSource dataSource;
  ReciveCodeRepository(this.dataSource);

  @override
  Future<List<ReciveCodeInfo>> Code(int smsCode) => dataSource.code(smsCode);
}
