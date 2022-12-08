import 'dart:io';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/root.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

final UiAddressIp getAddress2 = Get.put(UiAddressIp());
final UiConst _Const = Get.put(UiConst());

class _ConfirmationState extends State<Confirmation> {
  StepperType stepperType = StepperType.vertical;
  @override
  void initState() {
    super.initState();
    // getstep();
  }

  final UiPhoneController phoneController = Get.put(UiPhoneController());
  final UiStatemadrak statemadrakt = Get.put(UiStatemadrak());

  int _currentStep = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: size.width * 0.9,
        height: size.height * 0.06,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            exit(0);
            // Get.to(
            //   () => const Directionality(
            //     textDirection: TextDirection.rtl,
            //     child: RootScreen(),
            //   ),
            // );
          },
          label: const Text(
            'تایید',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text(_Const.ConstTitle.value),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            //we need to return a future
            return Future.value(false);
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
            child: SizedBox(
              width: size.width,
              height: size.height * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      'assets/images/confirmation.png',
                      // width: 400,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: size.height * 0.14,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(
                      //   width: 1,
                      //   color: Colors.black26,
                      // ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          offset: Offset(1, 1), // Shadow position
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          _Const.ConstDesc.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black54,
                            height: 2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
