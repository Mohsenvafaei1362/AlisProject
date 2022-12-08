import 'dart:async';

import 'package:local_notification_flutter_project/ui/models/message_box/data_message_box.dart';
import 'package:local_notification_flutter_project/ui/models/message_box/message_box_post/message_post1.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../controller/controller.dart';

class Message_Box extends StatefulWidget {
  const Message_Box({Key? key}) : super(key: key);

  @override
  State<Message_Box> createState() => _Message_BoxState();
}

class _Message_BoxState extends State<Message_Box> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product3 = AllProducts3.products3;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: HomeScreen_Ui())));
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  ),
                  Text('صندوق پیام ها'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '(2 پیغام خوانده نشده)'.toPersianDigit(),
                    style: TextStyle(fontSize: 8),
                  )
                ],
              ),
            ),
            Container(
              width: size.width,
              height: size.height,
              child: ListView.builder(
                itemCount: product3.length,
                itemBuilder: (context, index) {
                  final data = product3[index];
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => Directionality(
                        //       textDirection: TextDirection.rtl,
                        //       child: Message_Post1(
                        //         message: product3[index],
                        //       ),
                        //     ),
                        //   ),
                        // );
                      },
                      child: Container(
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                data.image,
                                width: 68,
                                height: 68,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data.title,
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  data.title2,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black45),
                                ),
                                Text(
                                  data.title3,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black45),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
