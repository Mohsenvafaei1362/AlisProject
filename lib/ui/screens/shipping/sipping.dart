import 'dart:async';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/orderInfo.dart';
import 'package:local_notification_flutter_project/ui/data/repo/order_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/cart/price_info.dart';
import 'package:local_notification_flutter_project/ui/screens/payment_webview/payment_webview.dart';
import 'package:local_notification_flutter_project/ui/screens/recipt/payment_receipt.dart';
import 'package:local_notification_flutter_project/ui/screens/shipping/bloc/shipping_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingScreen extends StatefulWidget {
  final num payablePrice;
  final num shippingCost;
  final num totalPrice;

  ShippingScreen({
    Key? key,
    required this.payablePrice,
    required this.shippingCost,
    required this.totalPrice,
  }) : super(key: key);

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController postalCodeController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  StreamSubscription? subscription;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحویل گیرنده'),
      ),
      body: BlocProvider<ShippingBloc>(
        create: (context) {
          final bloc = ShippingBloc(orderRepository);
          subscription = bloc.stream.listen((event) {
            if (event is ShippingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(event.exception.message)),
              );
            } else if (event is ShippingSuccess) {
              if (event.result.bankGatewayUrl.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentGetWayScreen(
                      bankGatewayUrl: event.result.bankGatewayUrl,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentReceiptScreen(
                      orderId: event.result.orderId,
                    ),
                  ),
                );
              }
            }
          });
          return bloc;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  label: Text('نام'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  label: Text('نام خانوادگی'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  label: Text('شماره تماس'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: postalCodeController,
                decoration: const InputDecoration(
                  label: Text('کد پستی'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  label: Text('آدرس'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              PriceInfo(
                payablePrice: widget.payablePrice,
                shippingCost: widget.shippingCost,
                totalPrice: widget.totalPrice,
                // payablePrice: widget.payablePrice,
                // shippingCost: widget.shippingCost,
                // totalPrice: widget.totalPrice,
              ),
              BlocBuilder<ShippingBloc, ShippingState>(
                builder: (context, state) {
                  return state is ShippingLoading
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                BlocProvider.of<ShippingBloc>(context).add(
                                  ShippingCreateOrder(
                                    CreateOrderParams(
                                      firstNameController.text,
                                      lastNameController.text,
                                      phoneNumberController.text,
                                      postalCodeController.text,
                                      addressController.text,
                                      PaymentMethod.cashOnDelivery,
                                    ),
                                  ),
                                );
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => PaymentReceiptScreen()),
                                // );
                              },
                              child: const Text('پرداخت در محل'),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<ShippingBloc>(context).add(
                                  ShippingCreateOrder(
                                    CreateOrderParams(
                                      firstNameController.text,
                                      lastNameController.text,
                                      phoneNumberController.text,
                                      postalCodeController.text,
                                      addressController.text,
                                      PaymentMethod.online,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('پرداخت اینترنتی'),
                            ),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
