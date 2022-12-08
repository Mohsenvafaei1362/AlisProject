class EditDlDto {
  const EditDlDto(
    this.FName,
    this.LName,
    this.Email,
    this.NationalCode,
    this.EparchyRef,
    this.CityRef,
    this.PostalCode,
    this.CityName,
    this.EparchyName,
  );

  final String FName;
  final String LName;
  final String Email;
  final int NationalCode;
  final int EparchyRef;
  final int CityRef;
  final int PostalCode;
  final String CityName;
  final String EparchyName;

  // EditDlDto.fromJson(Map json)
  //     : FName = json['FName'],
  //       LName = json['LName'],
  //       Email = json['Email'],
  //       NationalCode = json['NationalCode'],
  //       EparchyRef = json['EparchyRef'],
  //       CityRef = json['CityRef'],
  //       PostalCode = json['PostalCode'],
  //       CityName = json['CityName'],
  //       EparchyName = json['EparchyName'];
}


// class UserDto {
//   const UserDto({
//     this.DlId = 0,
//     this.FName = 'محسن',
//     this.LName = 'وفائی',
//     this.Email = 'vafaei@',
//     this.NationalCode = 0,
//     this.EparchyRef = 0,
//     this.CityRef = 0,
//     this.PostalCode = 0,
//     this.CityName = 'مشهد',
//     this.EparchyName = 'خراسان',
//   });

//   final int DlId;
//   final String FName;
//   final String LName;
//   final String Email;
//   final int NationalCode;
//   final int EparchyRef;
//   final int CityRef;
//   final int PostalCode;
//   final String CityName;
//   final String EparchyName;

//   UserDto.fromJson(Map json)
//       : DlId = json['DlId'],
//         FName = json['FName'],
//         LName = json['LName'],
//         Email = json['Email'],
//         NationalCode = json['NationalCode'],
//         EparchyRef = json['EparchyRef'],
//         CityRef = json['CityRef'],
//         PostalCode = json['PostalCode'],
//         CityName = json['CityName'],
//         EparchyName = json['EparchyName'];

//   Map<String, dynamic> toJson() {
//     return {
//       'FName': FName,
//       'LName': LName,
//       'Email': Email,
//     };
//   }
// }
