import 'package:local_notification_flutter_project/ui/data/ClassInfo/race_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/race_data_source.dart';

final raceRepository = RaceRepository(RaceRemoteDataSource(httpClient));

abstract class IRaceRepository {
  Future<List<RaceInfo>> race();
}

class RaceRepository implements IRaceRepository {
  final IRaceDataSource dataSource;

  RaceRepository(this.dataSource);
  @override
  Future<List<RaceInfo>> race() => dataSource.race();
}
