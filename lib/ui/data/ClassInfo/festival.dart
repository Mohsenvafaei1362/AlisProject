class FestivalInfo {
  final String title;
  final int countVisited;

  FestivalInfo(this.title, this.countVisited);

  FestivalInfo.fromJson(Map json)
      : title = json["title"],
        countVisited = json["countVisited"];
}
