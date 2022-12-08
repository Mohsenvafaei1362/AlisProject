class PreviewInfoClass {
  final String FName;
  final String LName;
  final int NationalCode;
  final String Email;
  final String Eparchy;
  final String City;
  final int PostalCode;
  final String Role;

  PreviewInfoClass(this.FName, this.LName, this.NationalCode, this.Email,
      this.Eparchy, this.City, this.PostalCode, this.Role);

  PreviewInfoClass.fromJson(Map json)
      : FName = json['FName'],
        LName = json['LName'],
        NationalCode = json['NationalCode'],
        Email = json['Email'],
        Eparchy = json['Eparchy'],
        City = json['City'],
        PostalCode = json['PostalCode'],
        Role = json['Role'];
}
