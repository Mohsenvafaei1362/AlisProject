import 'dart:convert';

import 'package:local_notification_flutter_project/ui/data/ClassInfo/message_box_info.dart';
import 'package:local_notification_flutter_project/ui/screens/MessageBox/message_box.dart';
import 'package:flutter/material.dart';

class Message_Post1 extends StatefulWidget {
  const Message_Post1({Key? key, required this.message, required this.index})
      : super(key: key);
  final List<MessageCount> message;
  final int index;

  @override
  State<Message_Post1> createState() => _Message_Post1State();
}

class _Message_Post1State extends State<Message_Post1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: MessageBox()),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.5,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                    ),
                    // image: DecorationImage(
                    //   image: AssetImage(widget),
                    // ),
                  ),
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      final data = widget.message[widget.index];
                      var avatar = base64.decode(data.Avatar.toString());
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                avatar,
                                width: 68,
                                height: 68,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              data.PersianDate,
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.black45),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              data.Title,
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        data.Desc,
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
