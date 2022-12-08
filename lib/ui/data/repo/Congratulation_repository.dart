import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/Congratulation_data_source.dart';

final congratulationRepository =
    CongratulationRepository(CongratulationRemoteDataSource(httpClient));

abstract class ICongratulationRepository {
  Future<int> isActive();
}

class CongratulationRepository implements ICongratulationRepository {
  final ICongratulationDataSource dataSource;

  CongratulationRepository(this.dataSource);
  @override
  Future<int> isActive() => dataSource.isActive();
}
