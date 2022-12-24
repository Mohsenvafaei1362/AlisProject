import 'dart:async';
import 'dart:math';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class LuckWheel extends StatefulWidget {
  const LuckWheel({key});

  @override
  State<LuckWheel> createState() => _LuckWheelState();
}

Random random = new Random();
StreamController<int> controller = StreamController<int>();

class _LuckWheelState extends State<LuckWheel> {
  StreamController<int> selected = StreamController<int>();
  final items = <String>[
    '${random.nextInt(100)} '.toPersianDigit(),
    '${random.nextInt(100)} '.toPersianDigit(),
    '${random.nextInt(100)} '.toPersianDigit(),
    '${random.nextInt(100)} '.toPersianDigit(),
    '${random.nextInt(100)} '.toPersianDigit(),
    '${random.nextInt(100)} '.toPersianDigit(),
    '${random.nextInt(100)} '.toPersianDigit(),
    '${random.nextInt(100)} '.toPersianDigit(),
  ];
  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Random random = new Random();

    return Scaffold(
      appBar: AppBar(
        title: Text('گردونه شانس'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(
            () {
              selected.add(
                Fortune.randomInt(0, items.length),
              );
              print('selected.toString() : ${selected.toString()}');
            },
          );
        },
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.8,
                    alignment: Alignment.center,
                    child: FortuneWheel(
                      alignment: Alignment.center,
                      selected: selected.stream,
                      indicators: <FortuneIndicator>[
                        FortuneIndicator(
                          alignment: Alignment
                              .bottomCenter, // <-- changing the position of the indicator
                          child: TriangleIndicator(
                            color: Colors
                                .amber, // <-- changing the color of the indicator
                          ),
                        ),
                      ],
                      items: [
                        for (var it in items)
                          FortuneItem(
                            // style: FortuneItemStyle(
                            //   borderColor: Colors.red,
                            //   color: Colors.lightBlue,
                            //   textAlign: TextAlign.center,
                            // ),
                            child: RichText(
                              text: TextSpan(
                                  text: it.toPersianDigit(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  children: const [
                                    TextSpan(
                                      text: 'امتیاز',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ]),
                            ),
                            // Text(
                            //   it,
                            //   style: TextStyle(
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ),
                      ],
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
