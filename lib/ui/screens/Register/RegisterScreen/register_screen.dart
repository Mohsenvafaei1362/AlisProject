import 'dart:convert';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/auth_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/cart_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/GetSmsCode/get_sms_code.dart';
import 'package:local_notification_flutter_project/ui/screens/auth/bloc/auth_bloc.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({
    Key? key,
    required this.onChanged,
    required this.timeout,
  }) : super(key: key);
  final ValueChanged onChanged;
  int timeout;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

final UiTimeStep timeStep = Get.put(UiTimeStep());
///save information about the current client
  ///ذخیره اطلاعات در مورد مشتری فعلی
final UiPhoneController phoneController = Get.put(UiPhoneController());
final UiLog phoneId = Get.put(UiLog());

class _RegisterScreenState extends State<RegisterScreen> {
  int clicked = 0;
  String? data;
  // bool code = false;
  bool canResendCode = true;
  bool validphone = false;
  Map<String, dynamic>? _info;

  String? idPhone;

  getTime1() {
    setState(() {
      canResendCode = !canResendCode;
    });
  }

  _getInfo() async {
    // Instantiating the plugin
    final deviceInfoPlugin = DeviceInfoPlugin();

    final result = await deviceInfoPlugin.deviceInfo;
    setState(() {
      _info = result.toMap();
      idPhone = jsonEncode(result.toMap()['id']);
    });
    // print(_info);
  }

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  List<Widget> myWidgetList = [
    const Text(""),
  ];
  bool show = false;
  bool isActiveButton = false;
  String? title;
  final DeviceInfoPlugin dev = DeviceInfoPlugin();
  @override
  Widget build(BuildContext context) {
    // phoneId.id.value = idPhone!;
    // print('print : ${idPhone}');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // drawer: NavBar(),
      backgroundColor: Colors.white,

      // appBar: AppBar(),
      body: BlocProvider<AuthBloc>(
        create: (context) {
          final bloc = AuthBloc(authRepository, cartRepository: cartRepository);
          bloc.stream.forEach((state) {
            if (state is AuthSuccess) {
              Navigator.of(context).pop();
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.appException.message),
                ),
              );
            }
          });
          bloc.add(AuthStarted());
          return bloc;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.keyboard_arrow_right),
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
                              timeStep.timestep.value > 0
                                  ? CircularCountDownTimer(
                                      // duration: duration1.du2.value,
                                      duration: timeStep.timestep.value,
                                      initialDuration: 0,
                                      controller: CountDownController(),
                                      width: 0,
                                      height: 0,
                                      ringColor: const Color.fromARGB(
                                          255, 236, 235, 235),
                                      ringGradient: null,
                                      fillColor: const Color.fromARGB(
                                          255, 141, 138, 141),
                                      fillGradient: null,
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      backgroundGradient: null,
                                      strokeWidth: 8.0,
                                      strokeCap: StrokeCap.round,
                                      textStyle: const TextStyle(
                                          fontSize: 15.0,
                                          color: Color.fromARGB(255, 7, 7, 7),
                                          fontWeight: FontWeight.bold),
                                      textFormat: CountdownTextFormat.S,
                                      isReverse: true,
                                      isReverseAnimation: true,
                                      isTimerTextShown: true,
                                      autoStart: true,
                                      onStart: () {
                                        // debugPrint('Countdown Started');
                                      },
                                      onComplete: () {
                                        setState(() {
                                          canResendCode = !canResendCode;
                                        });
                                        // debugPrint('Countdown Ended');
                                      },
                                      onChange: (String timeStamp) {
                                        // debugPrint('Countdown Changed $timeStamp');
                                        timeStep.timestep.value =
                                            int.parse(timeStamp);
                                      },
                                    )
                                  : Container(),

                              TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [],
                                style: const TextStyle(
                                  fontFamily: 'IransansDn',
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: "تلفن همراه",
                                  prefixIcon: const Icon(Icons.mobile_friendly),
                                ),
                                controller: phoneController.phoneController,
                                onChanged: (String value) {
                                  setState(() {
                                    title = value;
                                  });
                                  print(value.toPersianDigit());
                                },
                                onSaved: (value) {
                                  phoneController.phone.value =
                                      value!.toPersianDigit();
                                },
                                validator: (value) {
                                  return phoneController.validatePhone(value!);
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              // Spacer(),
                              // clicked == 0
                              //     ?
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
                                    phoneController.phone.value =
                                        phoneController.phoneController.text;
                                    // if (clicked == 1) {
                                    //   print('غیر مجاز');
                                    //   return;
                                    // } else if (clicked == 0) {
                                    if (phoneController.phoneController.text
                                            .isValidIranianMobileNumber() ==
                                        false) {
                                      validphone = true;

                                      // print(validphone);
                                      // print(
                                      //     'شماره موبایل وارد شده صحیح نمی باشد');
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Center(
                                            child: Text(
                                              '! توجه',
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          content: const Text(
                                            '.شماره موبایل وارد شده صحیح نمی باشد',
                                            style:
                                                TextStyle(color: Colors.pink),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('متوجه شدم'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      validphone = false;
                                      // setState(() {
                                      //   clicked = 1;
                                      //   // isActiveButton = true;
                                      // });
                                      if (state is AuthLoading) {
                                        return;
                                      } else if (timeStep.timestep.value == 0) {
                                        BlocProvider.of<AuthBloc>(context).add(
                                          AuthButtonRegisterIsClicked(
                                            phoneController
                                                .phoneController.text,
                                            idPhone.toString(),
                                          ),
                                        );
                                        phoneController.phoneController.text =
                                            '';
                                        // authRepository.register(
                                        //     phoneController.phoneController.text);
                                        // putregistersmsreq();
                                      } else {
                                        Get.to(
                                          GetSmsCode(
                                              onChanged: (value) {},
                                              timeout: timeStep.timestep.value),
                                        );
                                      }
                                    }
                                    // }
                                  },
                                  child: state is AuthLoading
                                      ? const CupertinoActivityIndicator(
                                          color: Colors.white,
                                        )
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
