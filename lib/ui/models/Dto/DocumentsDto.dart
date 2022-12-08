class UiDocumentsInfo {
  const UiDocumentsInfo({
    required this.modelId,
    required this.userRef,
    required this.dlRef,
    required this.desc,
    required this.phoneNumber,
    required this.registerLevelRef,
    required this.ModelTitle,
    required this.pic,
    required this.tableRef,
    required this.tableTitle,
    required this.Creator,
  });

  final String ModelTitle;
  final String pic;
  final int modelId;
  final int userRef;
  final int dlRef;
  final String desc;
  final String phoneNumber;
  final String registerLevelRef;
  final int tableRef;
  final String tableTitle;
  final int Creator;

  // UiDocumentsInfo.fromJson(Map json)
  //     : pic_model = json['picModel'],
  //       modelId = json['modelId'],
  //       userRef = json['userRef'],
  //       dlRef = json['dlRef'],
  //       desc = json['desc'],
  //       phoneNumber = json['phoneNumber'],
  //       registerLevelRef = json['registerLevelRef'];
}
