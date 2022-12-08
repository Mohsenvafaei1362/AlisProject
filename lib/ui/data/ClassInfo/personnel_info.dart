class PersonnelInfo {
  final String fname;
  final String lname;
  final String namestore;
  final int nationalcode;
  final int phonenumber;

  PersonnelInfo(
    this.fname,
    this.lname,
    this.namestore,
    this.nationalcode,
    this.phonenumber,
  );
  PersonnelInfo.fromJson(Map json)
      : fname = json['fname'],
        lname = json['lname'],
        nationalcode = json['nationalcode'],
        phonenumber = json['phonenumber'],
        namestore = json['namestore'];

  static List<PersonnelInfo> parseJsonArray(List<dynamic> jsonArray) {
    final List<PersonnelInfo> personnel = [];
    jsonArray.forEach(
      (element) {
        personnel.add(
          PersonnelInfo.fromJson(element),
        );
      },
    );
    return personnel;
  }
}
