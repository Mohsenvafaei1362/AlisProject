import 'package:flutter/material.dart';

class Dialog extends StatelessWidget {
  const Dialog({
    Key? key,
    required this.context,
    required this.warning,
    required this.title,
    required this.button,
  }) : super(key: key);

  final BuildContext context;
  final String warning;
  final String title;
  final String button;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        warning,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.amber,
        ),
      ),
      content: Text(
        title,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              button,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
