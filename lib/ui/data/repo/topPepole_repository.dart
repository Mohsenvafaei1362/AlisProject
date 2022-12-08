import 'package:local_notification_flutter_project/ui/data/ClassInfo/topPepole.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/topPepole_data_source.dart';

final topPepoleRepository =
    TopPepoleRepository(TopPepoleRemoteDataSource(httpClient));

abstract class ITopPepoleRepository {
  Future<List<TopPepoleInfo>> topPepole();
}

class TopPepoleRepository implements ITopPepoleRepository {
  final ITopPepoleDataSource dataSource;

  TopPepoleRepository(this.dataSource);
  @override
  Future<List<TopPepoleInfo>> topPepole() => dataSource.topPepoleInfo();
}
