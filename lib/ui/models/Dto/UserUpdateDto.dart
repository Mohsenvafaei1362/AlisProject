class Ui_UserUpdateDto {
  const Ui_UserUpdateDto(
    this.RoleTitleEn,
    this.Fname,
    this.LName,
    this.Email,
    this.Natinalcode,
    this.OstanId,
    this.CityId,
    this.PostalCode,
    this.CityName,
    this.OstanNAme,
  );
  final String RoleTitleEn;
  final String Fname;
  final String LName;
  final String Email;
  final int Natinalcode;
  final int OstanId;
  final int CityId;
  final int PostalCode;
  final String CityName;
  final String OstanNAme;

  // UserUpdateDto.fromJson(Map json)
  //     : RoleTitleEn = json['RoleTitleEn'],
  //       Fname = json['Fname'],
  //       LName = json['LName'],
  //       Email = json['Email'],
  //       Natinalcode = json['Natinalcode'],
  //       OstanId = json['OstanId'],
  //       CityId = json['CityId'],
  //       PostalCode = json['PostalCode'],
  //       CityName = json['CityName'],
  //       OstanNAme = json['OstanNAme'];
}
