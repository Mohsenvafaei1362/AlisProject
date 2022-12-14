class TestUserInfo {
  final String usr_username;
  final String usr_firstname;
  final String usr_lastname;

  TestUserInfo(this.usr_username, this.usr_firstname, this.usr_lastname);

  TestUserInfo.fromJson(Map json)
      : usr_username = json['usr_username'],
        usr_firstname = json['usr_firstname'],
        usr_lastname = json['usr_lastname'];
}
