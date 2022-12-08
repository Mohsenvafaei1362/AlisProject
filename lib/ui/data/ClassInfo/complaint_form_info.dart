class ComplaintFormInfo {
  final String title;
  final String fullname;
  final String email;
  final int phone;
  final int codeorder;
  final String description;
  final String image;

  ComplaintFormInfo(
    this.title,
    this.fullname,
    this.email,
    this.phone,
    this.codeorder,
    this.description,
    this.image,
  );

  ComplaintFormInfo.fromJson(Map json)
      : title = json['title'],
        fullname = json['fullname'],
        email = json['email'],
        phone = json['phone'],
        codeorder = json['codeorder'],
        description = json['description'],
        image = json['image'];
}
