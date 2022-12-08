class AuthInfo {
  // final String accessToken;
  // final String refreshToken;
  final int userId;
  final int roleId;
  final int dlRef;
  final String roleTitle;
  final String roleTitleEn;
  final String userName;
  final int visitorRef;
  final int sellsCenterRef;
  final int usersGroupRef;

  AuthInfo(
    this.userId,
    this.roleId,
    this.dlRef,
    this.roleTitle,
    this.roleTitleEn,
    this.userName,
    this.visitorRef,
    this.sellsCenterRef,
    this.usersGroupRef,
    // this.accessToken,
    // this.refreshToken,
  );
  AuthInfo.fromJson(Map json)
      : userId = json['userId'],
        roleId = json['roleId'],
        dlRef = json['dlRef'],
        roleTitle = json['roleTitle'],
        roleTitleEn = json['roleTitleEn'],
        visitorRef = json['visitorRef'],
        sellsCenterRef = json['sellsCenterRef'],
        usersGroupRef = json['usersGroupRef'],
        userName = json['userName'];
}

class GetTimedata {
  final bool del;

  GetTimedata(
    this.del,
  );
  GetTimedata.fromJson(Map json) : del = json['del'];
}
