class CityModel {
  final int CityId;
  final String CityName;

  CityModel({
    required this.CityId,
    required this.CityName,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    // if (json == null) return Container();
    return CityModel(
      CityId: json["cityId"],
      CityName: json["cityName"],
    );
  }

  static List<CityModel> fromJsonList(List list) {
    // if (list == null) return null;
    return list.map((item) => CityModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.CityId.toString()} ${this.CityName}';
  }

  ///this method will prevent the override of toString
  bool userFilterByCreationDate(String filter) {
    return this.CityName.toString().contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(CityModel model) {
    return this.CityId == model.CityId;
  }

  @override
  String toString() => CityName;
}
