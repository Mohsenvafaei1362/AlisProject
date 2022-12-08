import 'package:local_notification_flutter_project/ui/data/ClassInfo/Details_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/Details_data_source.dart';

final detailsRepository =
    DetailsRepository(DetailsRemoteDataSource(httpClient));

abstract class IDetailsRepository {
  Future<List<DetailsInfo>> details();
}

class DetailsRepository implements IDetailsRepository {
  final IDetailsDataSource dataSource;

  DetailsRepository(this.dataSource);
  @override
  Future<List<DetailsInfo>> details() => dataSource.details();
}
