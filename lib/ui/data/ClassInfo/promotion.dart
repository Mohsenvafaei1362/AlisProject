class PromotionInfo {
  final String title;
  // final String description;

  PromotionInfo(
    this.title,
    // this.description,
  );
  PromotionInfo.fromJson(Map json) : title = json['title'];
  // description = json['description'];
}
