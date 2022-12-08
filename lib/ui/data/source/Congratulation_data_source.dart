import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/models/DL/getdl.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

final UiDl _dl = Get.put(UiDl());

abstract class ICongratulationDataSource {
  Future<int> isActive();
}

class CongratulationRemoteDataSource implements ICongratulationDataSource {
  final Dio httpClient;

  CongratulationRemoteDataSource(this.httpClient);
  @override
  Future<int> isActive() async {
    final response = await httpClient.get(
      "Dl",
      queryParameters: (<String, String>{
        "companyref": '1',
        "phonenumber": phoneController.phone.value,
      }),
    );
    if (response.statusCode != 200) {
      throw AppException();
    } else {
      if (response.data is List<dynamic>) {
        if ((response.data as List<dynamic>).length == 1) {
          var element = GetDll.fromJson((response.data as List<dynamic>).first);
          _dl.Company.value = element.CompanyTitle;
          _dl.CompanyRef.value = element.CompanyRef;
          _dl.DlCode.value = element.DlCode.toString();
          _dl.DlId.value = element.DlId;
          _dl.Email.value = element.Email;
          _dl.FName.value = element.FName;
          _dl.LName.value = element.LName;
          _dl.FullName.value = element.FullName;
          _dl.NastinalCode.value = element.NastinalCode;
          _dl.PhoneNumber.value = element.PhoneNumber;
          _dl.DlState = element.DlState;
          _dl.RegisterMemberLevelId.value = element.RegisterMemberLevelId;
          _dl.RegisterLevelCode.value = element.RegisterLevelCode;
          _dl.RegisterLevelTitle.value = element.RegisterLevelTitle;
          _dl.UserId.value = element.UserId;
          _dl.UserName.value = element.UserName;
          _dl.PostalCode.value = 0;
          _dl.Role.value = element.Role;
          _dl.Ostan.value = element.Eparchy;
          _dl.City.value = element.City;
          _dl.isActive = element.isActive;
        }
      }
      return _dl.DlState;
    }
  }
}
