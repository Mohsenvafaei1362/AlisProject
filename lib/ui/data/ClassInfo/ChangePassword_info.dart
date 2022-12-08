class ChangePasswordInfo {
  final int pass;

  ChangePasswordInfo(
    this.pass,
  );

  ChangePasswordInfo.fromJson(Map json) : pass = json['pass'];
}
