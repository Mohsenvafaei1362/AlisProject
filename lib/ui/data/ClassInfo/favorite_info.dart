class FavoriteInfo {
  final int productid;

  FavoriteInfo(
    this.productid,
  );
  FavoriteInfo.formJson(Map json) : productid = json['productid'];
}
