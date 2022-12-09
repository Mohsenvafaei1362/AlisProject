import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  final String _content = 'MTGPXY';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Listener(
      onPointerDown: (event) {},
      child: Scaffold(
        body: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/send2.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    // color: Colors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                          const Icon(
                            Icons.question_mark_rounded,
                            color: Colors.white,
                          ),
                        ]),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: size.width,
                    // color: Colors.red,
                    child: Column(
                      children: [
                        Text(
                          'دعوت از دوستان',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          '10 نفر از دوستان خود را به عالیس دعوت کنید و برای هر باز کردن حساب موفق 30 امتیاز هدیه بگیرید',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: size.width,
                    // color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(Icons.volunteer_activism),
                            Image.asset(
                              'assets/images/7978 (1).png',
                              width: 48,
                              height: 48,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'هدیه به دوستان',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(Icons.how_to_reg_rounded),
                            Image.asset(
                              'assets/images/7978 (2).png',
                              width: 48,
                              height: 48,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'دریافت امتیاز',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: size.width * 0.6,
                    color: Colors.yellow,
                    child: Container(
                      width: size.width / 2,
                      height: 35,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black),
                        gradient: const RadialGradient(
                          radius: 5,
                          colors: [
                            Color(0xffeef2f3),
                            Color(0xff005aa7),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          Clipboard.setData(const ClipboardData(text: 'MTGPXY'))
                              .then(
                            (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text("کد دعوت کپی شد"),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text('کد دعوت'),
                            Text('MTGPXY'),
                            Icon(Icons.copy),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: size.width,
                    // color: Colors.green,
                    child: Center(
                      child: SizedBox(
                        width: size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              )),
                          onPressed: () {
                            Share.share(_content);
                          },
                          child: const Text(
                            'ارسال دعوت نامه',
                            style: TextStyle(
                                fontSize: 11, fontFamily: 'IransansDn'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
