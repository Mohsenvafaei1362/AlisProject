import 'package:local_notification_flutter_project/ui/data/ClassInfo/Ghole_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/Ghole_data_source.dart';

final gholeRepository = GholeRepository(GholeRemoteDataSource(httpClient));

abstract class IGholeRepository {
  Future<List<GholeInfo>> ghole();
}

class GholeRepository implements IGholeRepository {
  final IGholeDataSource dataSource;

  GholeRepository(this.dataSource);
  @override
  Future<List<GholeInfo>> ghole() => dataSource.ghole();
}
