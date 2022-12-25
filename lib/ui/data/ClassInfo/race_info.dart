class RaceInfo {
  final int id;
  final String title;

  RaceInfo(this.id, this.title);

  RaceInfo.fromJson(Map json)
      : id = json["id"],
        title = json["title"];
}
