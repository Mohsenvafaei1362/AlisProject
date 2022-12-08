class DetailsInfo {
  final String title;
  DetailsInfo(
    this.title,
  );
  DetailsInfo.fromJson(Map json) : title = json['title'];
}
