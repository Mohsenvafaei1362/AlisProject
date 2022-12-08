class UserInfo {
  // final String FName;
  // final String LName;
  // final String Role;
  final int Score;

  UserInfo(
    // this.FName,
    // this.LName,
    // this.Role,
    this.Score,
  );
  UserInfo.fromJson(Map json)
      :
        // : FName = json['fName'],
        //   LName = json['lName'],
        //   Role = json['role'],
        Score = json['score'];
}
