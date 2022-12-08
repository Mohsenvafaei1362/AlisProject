import 'package:local_notification_flutter_project/ui/data/ClassInfo/cart_item.dart';

class CartResponse {
  final List<CartItemEntity> cartItems;
  int payablePrice;
  int totalPrice;
  int shippingConst;

  CartResponse.fromJson(Map<String, dynamic> json)
      : cartItems = CartItemEntity.parseJsonArray(
          json['cart_items'],
        ),
        payablePrice = json['payable_price'],
        totalPrice = json['total_price'],
        shippingConst = json['shipping_const'];
}

class CartResponseFake {
  int product_id;
  int product_code;
  int product_discount;
  int product_price;
  String product_Description;
  String product_name;
  String product_category;
  String image_product;

  CartResponseFake.fromJson(Map<String, dynamic> json)
      : product_id = json['product_id'][0] ?? 0,
        product_code = json['product_code'],
        product_discount = json['product_discount'],
        product_price = json['product_price'] ?? 0,
        product_Description = json['product_Description'] ?? '',
        product_name = json['product_name'] ?? '',
        product_category = json['product_category'] ?? '',
        image_product = json['image_product'] ?? '';
  // price = json['price'];
}
