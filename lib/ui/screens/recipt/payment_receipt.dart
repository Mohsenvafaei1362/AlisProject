import 'package:local_notification_flutter_project/ui/data/repo/order_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/recipt/bloc/payment_reciept_bloc.dart';
import 'package:local_notification_flutter_project/ui/theme/theme.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/pricelable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentReceiptScreen extends StatelessWidget {
  final int orderId;
  const PaymentReceiptScreen({key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'رسید پرداخت',
          ),
        ),
        body: BlocProvider<PaymentRecieptBloc>(
          create: (context) => PaymentRecieptBloc(orderRepository)
            ..add(PaymentRecieptStarted(orderId)),
          child: BlocBuilder<PaymentRecieptBloc, PaymentRecieptState>(
            builder: (context, state) {
              if (state is PaymentRecieptSuccess) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeData.dividerColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            state.paymentRecieptData.purchaseSuccess
                                ? 'پرداخت با موفقیت انجام شد'
                                : 'پرداخت ناموفق',
                            style: themeData.textTheme.headline6!
                                .apply(color: themeData.colorScheme.primary),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'وضعیت سفارش',
                                style: TextStyle(
                                  color: LightThemeColors.secondaryTextColor,
                                ),
                              ),
                              Text(
                                state.paymentRecieptData.paymentStatus,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 32,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'مبلغ',
                                style: TextStyle(
                                  color: LightThemeColors.secondaryTextColor,
                                ),
                              ),
                              Text(
                                state.paymentRecieptData.payablePrice
                                    .withPriceLable,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        child: const Text('بازگشت به صفحه اصلی'))
                  ],
                );
              } else if (state is PaymentRecieptError) {
                return Center(
                  child: Text(state.exception.message),
                );
              } else if (state is PaymentRecieptLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else {
                throw Exception('state is not supported');
              }
            },
          ),
        ),
      ),
    );
  }
}
