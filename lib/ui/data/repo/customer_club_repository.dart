import 'package:local_notification_flutter_project/ui/data/ClassInfo/customer_clubInfo.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/customer_club_datasource.dart';

final customerClubRepository =
    CustomerClubRepository(CustomerClubRemoteDataSource(httpClient));

abstract class ICustomerClubRepository {
  Future<List<CustomerClubInfo>> getUserInfo();
}

class CustomerClubRepository implements ICustomerClubRepository {
  final ICustomerClubDataSource dataSource;

  CustomerClubRepository(this.dataSource);
  @override
  Future<List<CustomerClubInfo>> getUserInfo() => dataSource.getUserInfo();
}
