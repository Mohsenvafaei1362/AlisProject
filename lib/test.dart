import 'dart:typed_data';

import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({
    key,
  });
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    Text('page is test'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
