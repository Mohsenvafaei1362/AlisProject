class TopPepoleInfo {
  final int rank;
  final int score;
  final String name;
  final String image;

  TopPepoleInfo(
    this.rank,
    this.score,
    this.name,
    this.image,
  );

  TopPepoleInfo.fromJson(Map json)
      : rank = json['rank'],
        score = json['score'],
        image = json['image'],
        name = json['name'];
}
