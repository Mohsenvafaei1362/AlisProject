import 'dart:async';
import 'dart:convert';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EndRegister extends StatefulWidget {
  EndRegister({Key? key}) : super(key: key);

  @override
  State<EndRegister> createState() => _EndRegisterState();
}

final UiAddressIp getAddress2 = Get.put(UiAddressIp());

class _EndRegisterState extends State<EndRegister> {
  final UiShowInfo showInfo = Get.put(UiShowInfo());
  final UiPhoneController phoneController = Get.put(UiPhoneController());
  final UiTimerUser timerUser = Get.put(UiTimerUser());
  // final UiFlag flag = Get.put(UiFlag());
  bool data = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: size.width * 0.9,
        height: size.height * 0.06,
        child: FloatingActionButton.extended(
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (Contex) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: HomeScreen_Ui(),
                ),
              ),
            );
          },
          label: const Text(
            'بزن بریم',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'IransansDn'),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: WillPopScope(
            onWillPop: () {
              //we need to return a future
              return Future.value(false);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width,
                  height: size.height / 2,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage('assets/images/879.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.height / 2.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('تبریک !'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('ثبت نام شما با موفقیت به اتمام رسید'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('به خانواده بزرگ عالیس خوش آمدید')
                    ],
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
