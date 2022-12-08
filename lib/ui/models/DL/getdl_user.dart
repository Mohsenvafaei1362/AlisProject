import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/models/const/getconst.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/IdentificationCode/IdentificationCode.dart';
import 'package:get/get.dart';

final UiPhoneController phoneController = Get.put(UiPhoneController());
final UiLog log = Get.put(UiLog());
final UiRegisterReq registerReq = Get.put(UiRegisterReq());
final UiResiveCodeFrm resiveCodeFrme = Get.put(UiResiveCodeFrm());
final UiDl _dl = Get.put(UiDl());
final UserInfo _userInfo = Get.put(UserInfo());

class GetDll {
  final int DlId, CompanyRef, DlState, RegisterMemberLevelId, UserId, RoleRef;
  final bool isActive;
  final String CompanyTitle,
      DlCode,
      PhoneNumber,
      FName,
      LName,
      FullName,
      NastinalCode,
      Email,
      RegisterLevelCode,
      UserName,
      RegisterLevelTitle,
      PostalCode,
      Role,
      Eparchy,
      Avatar,
      City;

  GetDll(
    this.DlId,
    this.UserId,
    this.DlCode,
    this.CompanyTitle,
    this.CompanyRef,
    this.PhoneNumber,
    this.FName,
    this.LName,
    this.FullName,
    this.NastinalCode,
    this.Email,
    this.DlState,
    this.RegisterMemberLevelId,
    this.RegisterLevelCode,
    this.RegisterLevelTitle,
    this.UserName,
    this.Role,
    this.Eparchy,
    this.City,
    this.PostalCode,
    this.RoleRef,
    this.isActive,
    this.Avatar,
  );
  GetDll.fromJson(Map json)
      : DlId = json['dlId'],
        CompanyTitle = json['companyTitle'],
        CompanyRef = json['companyRef'],
        PhoneNumber = json['phoneNumber'],
        FName = json['fName'],
        LName = json['lName'],
        FullName = json['fullName'],
        NastinalCode = json['nationalCode'],
        Email = json['email'],
        DlCode = json['dlCode'],
        DlState = json['dlState'],
        RegisterMemberLevelId = json['registerMemberLevelId'],
        RegisterLevelCode = json['registerLevelCode'],
        RegisterLevelTitle = json['registerLevelTitle'],
        UserId = json['userID'],
        UserName = json['userName'],
        Avatar = json['avatar'],
        PostalCode = json['postalCode'] ?? '',
        Role = json['roleTitle'] ?? '',
        Eparchy = json['eparchyName'] ?? '',
        City = json['cityName'] ?? '',
        isActive = json['isActive'] ?? '',
        RoleRef = json['roleRef'] ?? '';
}

Future<List<GetDll>> getdlUser(int dlref) async {
  final response = await httpClient.get(
    "Dl/User",
    queryParameters: (<String, String>{
      "DlRef": dlref.toString(),
    }),
  );
  if (response.statusCode != 200) {
    throw AppException();
  } else {
    final List<GetDll> getdl = [];

    if (response.data is List<dynamic>) {
      if ((response.data as List<dynamic>).length == 1) {
        getdl.add(GetDll.fromJson((response.data as List<dynamic>).first));
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
        _dl.PostalCode.value = int.parse(element.PostalCode);
        _dl.Role.value = element.Role;
        _dl.Ostan.value = element.Eparchy;
        _dl.City.value = element.City;
        _dl.Avatar.value = element.Avatar;
      } else {}
    }
    return getdl;
  }
}
