class AddNewStoreInfo {
  final String name;
  final String address;
  final String image;
  final String branchtype;
  final int phoneNumber;

  AddNewStoreInfo(
    this.name,
    this.address,
    this.image,
    this.branchtype,
    this.phoneNumber,
  );

  AddNewStoreInfo.fromJson(Map json)
      : name = json['name'],
        address = json['address'],
        image = json['image'],
        branchtype = json['branchtype'],
        phoneNumber = json['phoneNumber'];
}
