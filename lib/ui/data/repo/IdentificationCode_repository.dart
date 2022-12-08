import 'package:local_notification_flutter_project/ui/data/ClassInfo/IdentificationCodeInfo.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/IdentificationCode_datasource.dart';

final identificationCodeRepository = IdentificationCodeRepository(
    IdentificationCodeRemoteDataSource(httpClient));

abstract class IIdentificationCodeRepository {
  Future<List<IdentificationCodeInfo>> identificationCode(String code);
}

class IdentificationCodeRepository implements IIdentificationCodeRepository {
  final IIdentificationCodeDataSource dataSource;

  IdentificationCodeRepository(this.dataSource);
  @override
  Future<List<IdentificationCodeInfo>> identificationCode(String code) =>
      dataSource.identificationCode(code);
}
