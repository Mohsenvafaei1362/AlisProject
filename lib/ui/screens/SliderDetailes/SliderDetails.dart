import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SliderDetails extends StatefulWidget {
  const SliderDetails({key, required this.img, required this.link});
  final Uint8List img;
  final String link;
  @override
  State<SliderDetails> createState() => _SliderDetailsState();
}

class _SliderDetailsState extends State<SliderDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        // show the snackbar with some text
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The System Back Button is Deactivated')));
        return false;
      },
      child: SafeArea(
        child: WebView(
          initialUrl: 'https://www.google.com/',
        ),
      ),
    );
  }
}
