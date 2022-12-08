import 'package:local_notification_flutter_project/ui/data/ClassInfo/Club_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/Club_data_source.dart';

final clubRepository = ClubRepository(ClubRemoteDataSource(httpClient));

abstract class IClubRepository {
  Future<List<ClubInfo>> club();
}

class ClubRepository implements IClubRepository {
  final IClubDataSource dataSource;

  ClubRepository(this.dataSource);
  @override
  Future<List<ClubInfo>> club() => dataSource.club();
}
