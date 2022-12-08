import 'dart:async';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/screens/Support/ListTickets.dart';
import 'package:local_notification_flutter_project/ui/screens/Support/NewTicket.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Support extends StatefulWidget {
  const Support({Key? key}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  final UiTimerUser timerUser = Get.put(UiTimerUser());
  // final UiFlag flag = Get.put(UiFlag());
  late Timer timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.keyboard_arrow_right),
                    ),
                    const Text('مرکز پشتیبانی'),
                    const Icon(Icons.question_mark_rounded),
                  ],
                ),
              ),
              DefaultTabController(
                length: 2, // length of tabs
                initialIndex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const TabBar(
                      labelStyle: TextStyle(fontFamily: 'IransansDn'),
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(text: 'تیکت جدید'),
                        Tab(text: 'لیست تیکت ها'),
                      ],
                    ),
                    Container(
                      height: size.height * 0.84, //height of TabBarView
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.5))),
                      child: const TabBarView(
                        children: <Widget>[
                          NewTicket(),
                          ListTickets(),
                        ],
                      ),
                    ),
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
