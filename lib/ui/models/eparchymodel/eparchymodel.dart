class EparchyModel {
  final int EparchyId;
  final String EparchyTitle;

  EparchyModel({
    required this.EparchyId,
    required this.EparchyTitle,
  });

  factory EparchyModel.fromJson(Map<String, dynamic> json) {
    // if (json == null) return Container();
    return EparchyModel(
      EparchyId: json["eparchyId"],
      EparchyTitle: json["eparchyTitle"],
    );
  }

  static List<EparchyModel> fromJsonList(List list) {
    // if (list == null) return null;
    return list.map((item) => EparchyModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${EparchyId.toString()} $EparchyTitle';
  }

  ///this method will prevent the override of toString
  bool userFilterByCreationDate(String filter) {
    return EparchyTitle.toString().contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(EparchyModel model) {
    return EparchyId == model.EparchyId;
  }

  @override
  String toString() => EparchyTitle;
}
