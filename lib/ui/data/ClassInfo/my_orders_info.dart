import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';

class MyOrdersInfo {
  final int ordercode;
  final DateTime daterecord;
  final DateTime daterecive;
  final String title;
  final List<ProductEntity> product;

  MyOrdersInfo(
    this.ordercode,
    this.daterecord,
    this.daterecive,
    this.title,
    this.product,
  );

  MyOrdersInfo.fromJson(Map json)
      : product = ProductEntity.parseJsonArray(
          json['product'],
        ),
        daterecord = json['daterecord'],
        daterecive = json['daterecive'],
        title = json['title'],
        ordercode = json['ordercode'];
}
