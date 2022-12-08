class CategoryImageInfo {
  final String image;
  final String title;

  CategoryImageInfo(
    this.image,
    this.title,
  );
  CategoryImageInfo.fromJson(Map json)
      : image = json['image'],
        title = json['title'];
}
