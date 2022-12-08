class UiBannerEntity {
  final int id;
  final String imageUrl_1;
  final String imageUrl_2;
  final String imageUrl_3;
  UiBannerEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        imageUrl_1 = json['image1'],
        imageUrl_2 = json['image2'],
        imageUrl_3 = json['image3'];
}
