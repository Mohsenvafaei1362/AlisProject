import 'package:hive_flutter/hive_flutter.dart';

// part 'product.g.dart';

class UiProductSort {
  static const int latest = 0;
  static const int popular = 1;
  static const int priceHighToLow = 2;
  static const int priceLowToHigh = 3;

  static const List<String> names = [
    'جدیدترین',
    'پربازدیدترین',
    'قیمت نزولی',
    'قیمت صعودی',
  ];
}

// @HiveType(typeId: 0)
// class ProductEntity extends HiveObject {
//   // final int product_id;
//   @HiveField(0)
//   final int id;
//   @HiveField(1)
//   final int price;
//   @HiveField(2)
//   final int discount;
//   @HiveField(3)
//   final int previousPrice;
//   @HiveField(4)
//   final String title;
//   @HiveField(5)
//   final String imageUrl;

//   ProductEntity(
//     this.id,
//     this.price,
//     this.discount,
//     this.previousPrice,
//     this.title,
//     this.imageUrl,
//   );

//   ProductEntity.fromJson(Map json)
//       : id = json['product_id'][0],
//         // id = 100,
//         title = json['product_name'],
//         imageUrl = json['image_product'],
//         price = json['product_price'],
//         discount = json['product_discount'],
//         previousPrice = 100;

//   static List<ProductEntity> parseJsonArray(List<dynamic> jsonArray) {
//     final List<ProductEntity> productItems = [];
//     for (var element in jsonArray) {
//       productItems.add(
//         ProductEntity.fromJson(element),
//       );
//     }
//     return productItems;
//   }
// }

class ProductEntity {
  final int emtiaz;
  final num price;
  final int etebar;
  final int id;
  final int like;
  final String link;
  final int productid;
  final String productimg;
  final String productname;
  final double takhfif;
  final double semifinalprice;
  final double finalprice;

  ProductEntity(
    this.id,
    this.productid,
    this.productname,
    this.productimg,
    this.link,
    this.price,
    this.emtiaz,
    this.etebar,
    this.takhfif,
    this.finalprice,
    this.like,
    this.semifinalprice,
  );

  ProductEntity.fromJson(Map json)
      : id = json["id"],
        productid = json['productid'],
        productname = json['productname'],
        productimg = json['productimg'],
        link = json['link'],
        price = json['price'],
        emtiaz = json['emtiaz'],
        etebar = json['etebar'],
        finalprice = double.parse(json['finalprice'].toString()),
        takhfif = double.parse(json['takhfif'].toString()),
        semifinalprice = double.parse(json['semifinalprice'].toString()),
        like = json['like'];

  static List<ProductEntity> parseJsonArray(List<dynamic> jsonArray) {
    final List<ProductEntity> productItems = [];
    for (var element in jsonArray) {
      productItems.add(
        ProductEntity.fromJson(element),
      );
    }
    return productItems;
  }
}
