import 'package:hive_flutter/hive_flutter.dart';

part 'product.g.dart';

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

@HiveType(typeId: 0)
class ProductEntity extends HiveObject {
  // final int product_id;
  @HiveField(0)
  final int id;
  @HiveField(1)
  final double price;
  @HiveField(2)
  final String takhfif;
  @HiveField(3)
  final int previousPrice;
  @HiveField(4)
  final String title;
  @HiveField(5)
  final String imageUrl;
  final String like;
  final String etebar;
  final String finalprice;
  final String emtiaz;
  final int categoriesId;
  ProductEntity(
    this.id,
    this.price,
    this.takhfif,
    this.previousPrice,
    this.title,
    this.imageUrl,
    this.like,
    this.etebar,
    this.finalprice,
    this.emtiaz,
    this.categoriesId,
  );

  ProductEntity.fromJson(Map json)
      : id = json['id'],
        // id = 100,
        title = json['productname'],
        like = json['like'].toString(),
        imageUrl = json['productimg'].toString(),
        price = json['price'],
        categoriesId = json['categoriesID'],
        etebar = json['etebar'].toString(),
        takhfif = json['takhfif'].toString(),
        finalprice = json['finalprice'].toString(),
        previousPrice = json['finalprice'],
        emtiaz = json['emtiaz'].toString();

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
