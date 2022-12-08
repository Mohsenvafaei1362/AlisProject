import 'package:local_notification_flutter_project/ui/screens/recipt/payment_receipt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGetWayScreen extends StatelessWidget {
  final String bankGatewayUrl;
  const PaymentGetWayScreen({key, required this.bankGatewayUrl});

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: bankGatewayUrl,
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (url) {
        final uri = Uri.parse(url);

        if (uri.pathSegments.contains('checkout') && uri.host == 'alis.ir') {
          final orderId = int.parse(uri.queryParameters['order_id']!);
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PaymentReceiptScreen(
                      orderId: orderId,
                    )),
          );
        }
      },
    );
  }
}
