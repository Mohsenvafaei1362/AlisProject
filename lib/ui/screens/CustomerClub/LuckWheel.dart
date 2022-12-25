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

StreamController<int> _controller = StreamController.broadcast();

class _LuckWheelState extends State<LuckWheel> {
  // StreamController<int> selected = StreamController<int>();
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
    _controller.close();
    super.dispose();
  }

  @override
  void initState() {
    _controller.stream.listen((value) {
      print('Value from controller: $value');
      print('index : ${items[value]}');
      setState(() {
        numberLuckily = items[value];
      });
    });
    super.initState();
  }

  String numberLuckily = '';
  bool isShowNumberLuckily = false;
  showNumberLuckily() async {
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      isShowNumberLuckily = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('گردونه شانس'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(
            () {
              _controller.add(
                Fortune.randomInt(0, items.length),
              );
              showNumberLuckily();
            },
          );
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    // 'برای شروع روی گردونه کلیک کنید',
                    'شانست برای برنده شدن امتحان کن',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            isShowNumberLuckily
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      numberLuckily.length != 0
                          ? RichText(
                              text: TextSpan(
                                  text: 'تبریک شما موفق به دریافت',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' $numberLuckily',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.pink,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'امتیاز شدید',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ]),
                            )
                          // Text(
                          //     // 'امتیاز کسب شده شما : $numberLuckily',
                          //     'تبریک شما موفق به دریافت  $numberLuckily امتیاز کلابی شدید',
                          //     style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.black54,
                          //     ),
                          //   )
                          : Text(''),
                    ],
                  )
                : Container(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // color: Colors.amber,
                    width: size.width * 0.8,
                    height: size.height * 0.45,
                    alignment: Alignment.center,
                    child: FortuneWheel(
                      animateFirst: false,
                      alignment: Alignment.center,
                      selected: _controller.stream,
                      indicators: <FortuneIndicator>[
                        FortuneIndicator(
                          alignment: Alignment
                              .topCenter, // <-- changing the position of the indicator
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
