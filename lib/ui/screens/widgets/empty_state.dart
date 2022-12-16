import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final Widget? callToAction;
  final Widget image;
  const EmptyView(
      {Key? key, required this.message, this.callToAction, required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image,
        SizedBox(
          height: 10,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
        ),
        if (callToAction != null) callToAction!,
      ],
    );
  }
}
