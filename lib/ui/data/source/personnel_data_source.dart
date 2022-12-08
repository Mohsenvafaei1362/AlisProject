import 'package:local_notification_flutter_project/ui/data/ClassInfo/personnel_info.dart';
import 'package:dio/dio.dart';

abstract class IPersonnelDataSource {
  Future<List<PersonnelInfo>> personnel(
    String fname,
    String lname,
    String namestore,
    int nationalcode,
    int phonenumber,
  );
  Future<List<PersonnelInfo>> getpersonnel();
}

class PersonnelRemoteDataSource implements IPersonnelDataSource {
  final Dio httpClient;

  PersonnelRemoteDataSource(this.httpClient);
  @override
  Future<List<PersonnelInfo>> personnel(
    String fname,
    String lname,
    String namestore,
    int nationalcode,
    int phonenumber,
  ) async {
    final response = await httpClient.post('path', data: {
      'fname': fname,
      'lname': lname,
      'namestore': namestore,
      'nationalcode': nationalcode,
      'phonenumber': phonenumber,
    });
    final List<PersonnelInfo> personnel = [];
    for (var element in (response.data as List)) {
      personnel.add(PersonnelInfo.fromJson(element));
    }
    return personnel;
  }

  @override
  Future<List<PersonnelInfo>> getpersonnel() async {
    final response = await httpClient.get('path');
    final List<PersonnelInfo> getpersonnel = [];
    for (var element in (response.data as List)) {
      getpersonnel.add(PersonnelInfo.fromJson(element));
    }
    return getpersonnel;
  }
}
