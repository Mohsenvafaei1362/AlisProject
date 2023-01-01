import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';

part 'product.g.dart';

final ProductId _Pid = Get.put(ProductId());

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
  final int minBy;
  final int productId;
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
    this.minBy,
    this.productId,
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
        minBy = json['minbuy'],
        productId = json['productid'],
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

class PropertyEntity {
  final String title;
  final String newTitle;
  final String value1;
  final String value2;
  // final String sugarLoaf; //قند
  // final String fat; //چربی
  // final String salt; //نمک
  // final String acid; //اسیدهای چرب
  // final int licenseNumber; //شماره پروانه
  // final String product; //محصول
  // final int size; //سایز
  // final String packaging; //جنس بسته بندی
  // final int count; //تعداددر بسته
  // final int serial; //سریال
  // final int volume; //حجم

  PropertyEntity(
    this.title,
    this.value1,
    this.value2,
    this.newTitle,

    // this.sugarLoaf,
    // this.fat,
    // this.salt,
    // this.acid,
    // this.licenseNumber,
    // this.product,
    // this.size,
    // this.packaging,
    // this.count,
    // this.serial,
    // this.volume,
  );

  PropertyEntity.fromJson(Map json)
      : title = json['title'],
        newTitle = json['newTitle'],
        value1 = json['value1'],
        value2 = json['value2'];
  // sugarLoaf = json['sugarLoaf'],
  // fat = json['fat'],
  // salt = json['salt'],
  // acid = json['acid'],
  // licenseNumber = json['licenseNumber'],
  // product = json['product'],
  // size = json['size'],
  // packaging = json['packaging'],
  // count = json['count'],
  // serial = json['serial'],
  // volume = json['volume'];
}

@HiveType(typeId: 0)
class PromotionEntity extends HiveObject {
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
  final int minBy;
  final String text;
  final int productId;
  PromotionEntity(
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
    this.minBy,
    this.text,
    this.productId,
  );

  PromotionEntity.fromJson(Map json)
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
        minBy = json['minbuy'],
        text = json['text'],
        productId = json['productid'],
        emtiaz = json['emtiaz'].toString();
}
