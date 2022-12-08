import 'package:local_notification_flutter_project/ui/data/ClassInfo/lawInfo.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/law_data_source.dart';

final lawScreenRepository =
    LawScreenRepository(LawScreenRemoteDataSource(httpClient));

abstract class ILawScreenRepository {
  Future<List<LowInfo>> law(
      int RegisterLevelRef, String RegisterLevelCode, String RegisterLvelTitle);
}

class LawScreenRepository implements ILawScreenRepository {
  final ILawDataSource dataSource;
  LawScreenRepository(this.dataSource);
  @override
  Future<List<LowInfo>> law(int RegisterLevelRef, String RegisterLevelCode,
          String RegisterLvelTitle) =>
      dataSource.law(RegisterLevelRef, RegisterLevelCode, RegisterLvelTitle);
}
