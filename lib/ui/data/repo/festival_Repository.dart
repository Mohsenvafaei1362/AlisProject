import 'package:local_notification_flutter_project/ui/data/ClassInfo/festival.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/festival_data_source.dart';

final festivalRepository =
    FestivalRepository(FestivalRemoteDataSource(httpClient));

abstract class IFestivalRepository {
  Future<List<FestivalInfo>> festival();
}

class FestivalRepository implements IFestivalRepository {
  final IFestivalDataSource dataSource;

  FestivalRepository(this.dataSource);
  @override
  Future<List<FestivalInfo>> festival() => dataSource.festival();
}
