import 'package:flutter/material.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/pricelable.dart';

class Badge extends StatelessWidget {
  const Badge({key, required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      // visible: value == 0 ? false : true,
      visible: value.isNotEmpty,
      child: Container(
        width: 18,
        height: 18,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
          shape: BoxShape.circle,
        ),
        child: Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
