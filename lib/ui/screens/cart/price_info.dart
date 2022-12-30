import 'package:local_notification_flutter_project/ui/screens/widgets/pricelable.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class PriceInfo extends StatelessWidget {
  const PriceInfo(
      {key,
      required this.payablePrice,
      required this.shippingCost,
      required this.totalPrice});

  final num payablePrice;
  final num shippingCost;
  final num totalPrice;
  // final int payablePrice;
  // final int shippingCost;
  // final int totalPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 24, 0, 8),
          child: Text('جزئیات خرید'),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(8, 16, 8, 32),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(2), boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.07),
            ),
          ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('مبلغ کل خرید'),
                    RichText(
                      text: TextSpan(
                          text: '$totalPrice'
                              .separateByComma
                              .beToman()
                              .seRagham()
                              .toPersianDigit(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          children: const [
                            TextSpan(
                              text: ' تومان',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 10,
                                color: Colors.black54,
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('هزینه ارسال'),
                    if (shippingCost != 0)
                      RichText(
                        text: TextSpan(
                          text: '$shippingCost'
                              .separateByComma
                              .toString()
                              .beToman()
                              .seRagham()
                              .toPersianDigit(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          children: const [
                            TextSpan(
                              text: ' تومان',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (shippingCost == 0)
                      Text(
                        'رایگان',
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ],
                ),
              ),
              const Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('مبلغ قابل پرداخت'),
                    RichText(
                      text: TextSpan(
                          text: '$payablePrice'
                              .separateByComma
                              .beToman()
                              .seRagham()
                              .toPersianDigit(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          children: const [
                            TextSpan(
                                text: ' تومان',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                )),
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
