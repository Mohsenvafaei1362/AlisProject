import 'package:local_notification_flutter_project/ui/data/ClassInfo/personnel_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/personnel_data_source.dart';

final personnelRepository =
    PersonnelRepository(PersonnelRemoteDataSource(httpClient));

abstract class IPersonnelRepository {
  Future<List<PersonnelInfo>> personnel(
    String fname,
    String lname,
    String namestore,
    int nationalcode,
    int phonenumber,
  );
  Future<List<PersonnelInfo>> getpersonnel();
}

class PersonnelRepository implements IPersonnelRepository {
  final IPersonnelDataSource dataSource;

  PersonnelRepository(this.dataSource);
  @override
  Future<List<PersonnelInfo>> personnel(
    String fname,
    String lname,
    String namestore,
    int nationalcode,
    int phonenumber,
  ) {
    return dataSource.personnel(
      fname,
      lname,
      namestore,
      nationalcode,
      phonenumber,
    );
  }

  @override
  Future<List<PersonnelInfo>> getpersonnel() => dataSource.getpersonnel();
}
