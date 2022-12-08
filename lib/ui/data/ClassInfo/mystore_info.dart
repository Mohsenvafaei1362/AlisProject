class MyStoreInfo {
  final String namestore;
  final String branchtype;
  final String ConditionStore;
  final String ConditionBuy;
  final String address;
  final int phoneNumber;

  MyStoreInfo(
    this.namestore,
    this.branchtype,
    this.ConditionStore,
    this.ConditionBuy,
    this.address,
    this.phoneNumber,
  );
  MyStoreInfo.fromJson(Map json)
      : namestore = json['nameStore'],
        branchtype = json['branchtype'],
        ConditionStore = json['ConditionStore'],
        ConditionBuy = json['ConditionBuy'],
        address = json['address'],
        phoneNumber = json['phoneNumber'];
}
