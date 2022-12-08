import 'package:local_notification_flutter_project/ui/data/ClassInfo/confirmationInfo.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/confirmation_data_source.dart';

final confimationRepository =
    ConfirmationRepository(ConfirmationRemoteDataSource(httpClient));

abstract class IConfirmationRepository {
  Future<List<ConfirmationInfo>> confirmationState();
}

class ConfirmationRepository implements IConfirmationRepository {
  final IConfirmationDataSource dataSource;
  ConfirmationRepository(this.dataSource);
  @override
  Future<List<ConfirmationInfo>> confirmationState() =>
      dataSource.confirmationState();
}
