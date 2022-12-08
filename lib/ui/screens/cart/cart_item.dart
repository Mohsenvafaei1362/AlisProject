import 'package:local_notification_flutter_project/ui/data/ClassInfo/cart_item.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/cart_response.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/image_loading_service.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/pricelable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.data,
    required this.onDeleteButtonClicked,
    required this.onIncreaseButton,
    required this.onDecreaseButton,
  }) : super(key: key);

  final CartResponseFake data;
  // final CartItemEntity data;
  final GestureTapCallback onDeleteButtonClicked;
  final GestureTapCallback onIncreaseButton;
  final GestureTapCallback onDecreaseButton;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 3,
      child: Container(
        height: size.height * 0.2,
        width: size.width,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(20),
        //   // color: Colors.green,
        // ),
        // color: Colors.green,
        child: Row(
          children: [
            Container(
              width: size.width * 0.15,
              // color: Colors.amber,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: onDecreaseButton,
                    icon: const Icon(CupertinoIcons.minus_rectangle),
                  ),
                  Text(data.product_code.toString().toPersianDigit()),
                  IconButton(
                    onPressed: onIncreaseButton,
                    icon: const Icon(CupertinoIcons.plus_rectangle),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width * 0.45,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data.product_name),
                  data.product_discount != 0
                      ? SizedBox(
                          height: 5,
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  data.product_discount != 0
                      ? Text(
                          '${data.product_price.withPriceLable}'
                              .toPersianDigit(),
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                          ),
                        )
                      : SizedBox(
                          height: 5,
                        ),
                  Text(
                      '${(data.product_price - (data.product_price * (data.product_discount / 100))).withPriceLable}'
                          .toPersianDigit()),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.bottomLeft,
                    // color: Colors.amber,
                    child: TextButton(
                      onPressed: onDeleteButtonClicked,
                      child: const Text(
                        'حذف از سبد خرید',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: ClipOval(
                      child: Container(
                        // width: size.width * 0.2,
                        height: size.height * 0.04,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: size.height,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(20),
                    //   color: Colors.green,
                    // ),
                    // color: Colors.deepPurple,
                    child: ImageLoadingService(
                      imageUrl: data.image_product,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
