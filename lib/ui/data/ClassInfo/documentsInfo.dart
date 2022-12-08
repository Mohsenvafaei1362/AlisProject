class DocumentsInfo {
  final String imageUrl_1;
  final String imageUrl_2;
  final String imageUrl_3;
  final String imageUrl_4;

  DocumentsInfo(
      this.imageUrl_1, this.imageUrl_2, this.imageUrl_3, this.imageUrl_4);

  DocumentsInfo.fromJson(Map json)
      : imageUrl_1 = json['imageUrl_1'],
        imageUrl_2 = json['imageUrl_2'],
        imageUrl_3 = json['imageUrl_3'],
        imageUrl_4 = json['imageUrl_4'];
}
