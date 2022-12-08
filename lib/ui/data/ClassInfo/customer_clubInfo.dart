class CustomerClubInfo {
  final String FName;
  final String LName;
  final String Email;
  final String PhoneNumber;
  final int Ranke;
  final int Score;

  CustomerClubInfo(
    this.FName,
    this.LName,
    this.Email,
    this.PhoneNumber,
    this.Ranke,
    this.Score,
  );
  CustomerClubInfo.fromJson(Map json)
      : FName = json['FName'],
        LName = json['LName'],
        Email = json['Email'],
        PhoneNumber = json['PhoneNumber'],
        Ranke = json['Ranke'],
        Score = json['Score'];
}
