import 'package:local_notification_flutter_project/ui/data/ClassInfo/Partners_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/partners_datasource.dart';

final partnersRepository =
    PartnersRepository(PartnersRemoteDataSource(httpClient));

abstract class IPartnersRepository {
  Future<List<PartnersInfo>> partners();
}

class PartnersRepository implements IPartnersRepository {
  final IPartnersDataSource dataSource;

  PartnersRepository(this.dataSource);
  @override
  Future<List<PartnersInfo>> partners() => dataSource.partners();
}
