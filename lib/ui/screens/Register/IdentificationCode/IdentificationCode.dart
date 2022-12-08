import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/IdentificationCode_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/IdentificationCode/bloc/identification_code_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/otp_field.dart';

class IdentificationCode extends StatefulWidget {
  const IdentificationCode({
    Key? key,
    required this.onChanged,
  }) : super(key: key);
  final ValueChanged onChanged;

  @override
  State<IdentificationCode> createState() => _IdentificationCodeState();
}

final UiAddressIp getAddress2 = Get.put(UiAddressIp());

class _IdentificationCodeState extends State<IdentificationCode> {
  final UiPhoneController phoneController = Get.put(UiPhoneController());
  final UiTimerUser timerUser = Get.put(UiTimerUser());
  // final UiFlag flag = Get.put(UiFlag());
  final UiShowInfo showInfo = Get.put(UiShowInfo());
  String code = '';

  @override
  void initState() {
    super.initState();
  }

  checkCode() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "!!! توجه",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
        content: const Text(
          'کد وارد شده معتبر نمی باشد',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "متوجه شدم",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final PhoneController phoneController = Get.put(PhoneController());

    OtpFieldController otpController = OtpFieldController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // drawer: NavBar(),
      backgroundColor: Colors.white,
      // appBar: AppBar(),
      body: BlocProvider<IdentificationCodeBloc>(
        create: (context) {
          final bloc = IdentificationCodeBloc(identificationCodeRepository);
          bloc.add(IdentificationCodeStarted());
          return bloc;
        },
        child: BlocBuilder<IdentificationCodeBloc, IdentificationCodeState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                reverse: true,
                child: WillPopScope(
                  onWillPop: () {
                    //we need to return a future
                    return Future.value(false);
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.keyboard_arrow_right),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                        child: Container(
                          width: double.infinity,
                          // height: size.height,

                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'کد معرف را وارد فرمایید',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                                OTPTextField(
                                  keyboardType: TextInputType.text,
                                  controller: otpController,
                                  length: 5,
                                  width: MediaQuery.of(context).size.width,
                                  textFieldAlignment:
                                      MainAxisAlignment.spaceAround,
                                  fieldWidth: 45,
                                  // fieldStyle: Filesty.box,
                                  outlineBorderRadius: 10,
                                  style: const TextStyle(
                                    fontSize: 17,
                                  ),
                                  onChanged: (pin) {
                                    print("Changed: " + pin.toPersianDigit());
                                    // phoneController.moaref.value = pin;
                                    code = pin;
                                    print(code.length);
                                  },
                                  onCompleted: (pin) {
                                    print("Completed: " + pin.toPersianDigit());
                                    setState(() {
                                      // code = pin.toPersianDigit();
                                      phoneController.moaref.value = pin;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                // Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      onPrimary: Colors.white,
                                      minimumSize: Size(
                                          size.width * 0.9, size.height * 0.06),
                                      primary: Colors.blueAccent,
                                    ),
                                    onPressed: () {
                                      if (state is IdentificationCodeLoading) {
                                        return;
                                      } else if (code.length == 5) {
                                        BlocProvider.of<IdentificationCodeBloc>(
                                                context)
                                            .add(
                                                IdentificationCodeClickedButton(
                                                    code));
                                      } else {
                                        checkCode();
                                      }
                                    },
                                    child: state is IdentificationCodeLoading
                                        ? const CupertinoActivityIndicator()
                                        : const Text(
                                            'تایید',
                                            style: TextStyle(
                                                fontFamily: 'IransansDn'),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
