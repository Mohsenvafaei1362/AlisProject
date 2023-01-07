import 'dart:async';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/recivecode_repository.dart';
import 'package:local_notification_flutter_project/ui/models/DL/getdl.dart';
import 'package:local_notification_flutter_project/ui/models/register/registerrequest.dart';
import 'package:local_notification_flutter_project/ui/models/register/registersmsvalidation.dart';
import 'package:local_notification_flutter_project/ui/screens/register/getSmsCode/bloc/recivecode_bloc.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:telephony/telephony.dart';

class GetSmsCode extends StatefulWidget {
  GetSmsCode({
    Key? key,
    required this.onChanged,
    required this.timeout,
  }) : super(key: key);
  final ValueChanged onChanged;
  int timeout;

  @override
  State<GetSmsCode> createState() => _GetSmsCodeState();
}

final UiDuration1 duration1 = Get.put(UiDuration1());

class _GetSmsCodeState extends State<GetSmsCode> {
  final UiPhoneController phoneController = Get.put(UiPhoneController());
  OtpFieldController otpController = OtpFieldController();
  final TextEditingController codeController = TextEditingController();
  final UiTimeStep timeStep = Get.put(UiTimeStep());
  final UiResiveCodeFrm resiveCodeFrm = Get.put(UiResiveCodeFrm());
  final UiLog phoneId = Get.put(UiLog());

  bool canResendCode = true;
  bool validphone = false;
  Telephony telephony = Telephony.instance;
  OtpFieldController otpbox = OtpFieldController();
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();
    _listenSmsCode();
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription?.cancel;
    SmsAutoFill().unregisterListener();
  }

  _listenSmsCode() async {
    // await SmsAutoFill().listenForCode();
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        if (message.address == "98200014") {
          // //verify SMS is sent for OTP with sender number
          String otpcode =
              message.body.toString().replaceAll(RegExp('[^0-9]'), '');
          // //prase code from the OTP sms
          // otpbox.set(otpcode.split(""));
          // otpcode.substring(0, otpcode.length - 3);
          // //split otp code to list of number
          // //and populate to otb boxes

          setState(() {
            sms = otpcode.substring(0, otpcode.length - 3);
            // sms = message.body.toString();
          });
        } else {
          print("Normal message.");
        }
      },
      listenInBackground: false,
    );
  }

  // void test() {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: const Text(
  //         "!!! توجه",
  //         style: TextStyle(
  //           color: Colors.amber,
  //         ),
  //       ),
  //       content: const Text("کد وارد شده صحیح نمی باشد"),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(ctx).pop();
  //           },
  //           child: Container(
  //             padding: const EdgeInsets.all(14),
  //             decoration: BoxDecoration(
  //               color: Colors.lightBlue,
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: const Text(
  //               "متوجه شدم",
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  bool show = false;
  bool code = false;
  String getCode = '';

  ///show dialog when code is invalid
  ///زمانی که کد نامعتبر است، گفتگو را نشان دهید
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

  String sms = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // drawer: NavBar(),
      backgroundColor: Colors.white,

      // appBar: AppBar(),
      body: BlocProvider<RecivecodeBloc>(
        create: (context) {
          final bloc = RecivecodeBloc(reciveCodeRepository);
          streamSubscription = bloc.stream.listen((state) {
            if (state is ReciveCodeSuccess) {
              Navigator.of(context).pop();
            } else if (state is ReciveCodeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.appException.message),
                ),
              );
            }
          });
          bloc.add(ReciveCodeStarted());
          return bloc;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: BlocBuilder<RecivecodeBloc, RecivecodeState>(
                builder: (context, state) {
              return WillPopScope(
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
                            child: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
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
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  // putregistersmsreq();
                                  putregisterrequest(
                                      duration1.du2.value,
                                      phoneController.phone.value,
                                      phoneId.id.value);
                                  setState(() {
                                    phoneController.phone.value =
                                        phoneController.phoneController.text;
                                    canResendCode = !canResendCode;
                                  });
                                },
                                child: canResendCode == false
                                    ? const Text(
                                        'ارسال مجدد کد تایید',
                                        style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : const Text(''),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (canResendCode == true)
                                const Text(
                                  'کد تایید را وارد فرمایید',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (canResendCode == true)
                                Text(
                                  'کد تایید به شماره ${phoneController.phone.value} ارسال شد'
                                      .toPersianDigit(),
                                  style: const TextStyle(color: Colors.black45),
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              canResendCode == true
                                  ? PinFieldAutoFill(
                                      currentCode: sms,
                                      // sms.substring(startIndex, endIndex),
                                      onCodeChanged: (p0) {
                                        getCode = p0!;
                                        if (state is ReciveCodeLoading) {
                                          return;
                                        } else if (getCode.length == 5) {
                                          BlocProvider.of<RecivecodeBloc>(
                                                  context)
                                              .add(
                                            ReciveCodeButtonClicked(
                                              int.parse(
                                                sms,
                                                // resiveCodeFrm.code.value,
                                              ),
                                            ),
                                          );
                                        }
                                        //else {
                                        //   checkCode();
                                        // }
                                      },
                                      controller: codeController,
                                      codeLength: 5,
                                      autoFocus: true,
                                      decoration: UnderlineDecoration(
                                        lineHeight: 2,
                                        lineStrokeCap: StrokeCap.square,
                                        bgColorBuilder: PinListenColorBuilder(
                                          Colors.green.shade200,
                                          Colors.grey.shade200,
                                        ),
                                        colorBuilder: const FixedColorBuilder(
                                          Colors.transparent,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 20,
                              ),

                              if (canResendCode == true && widget.timeout == 0)
                                CircularCountDownTimer(
                                  duration: duration1.du2.value,
                                  // duration: timeStep.timestep.value,
                                  initialDuration: 0,
                                  controller: CountDownController(),
                                  width: MediaQuery.of(context).size.width / 8,
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  ringColor:
                                      const Color.fromARGB(255, 236, 235, 235),
                                  ringGradient: null,
                                  fillColor:
                                      const Color.fromARGB(255, 141, 138, 141),
                                  fillGradient: null,
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
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
                                      code = false;
                                    });
                                    // debugPrint('Countdown Ended');
                                  },
                                  onChange: (String timeStamp) {
                                    // debugPrint('Countdown Changed $timeStamp');
                                    timeStep.timestep.value =
                                        int.parse(timeStamp);
                                  },
                                )
                              else if (canResendCode == true &&
                                  widget.timeout > 0)
                                CircularCountDownTimer(
                                  duration: widget.timeout,
                                  // duration: timeStep.timestep.value,
                                  initialDuration: 0,
                                  controller: CountDownController(),
                                  width: MediaQuery.of(context).size.width / 8,
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  ringColor:
                                      const Color.fromARGB(255, 236, 235, 235),
                                  ringGradient: null,
                                  fillColor:
                                      const Color.fromARGB(255, 141, 138, 141),
                                  fillGradient: null,
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
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
                                    widget.timeout = int.parse(timeStamp);
                                    timeStep.timestep.value =
                                        int.parse(timeStamp);
                                    // print(timeStamp);
                                  },
                                ),

                              const SizedBox(
                                height: 20,
                              ),

                              // Spacer(),
                              canResendCode == true
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          onPrimary: Colors.white,
                                          minimumSize: Size(size.width * 0.9,
                                              size.height * 0.06),
                                          primary: Colors.blueAccent,
                                        ),
                                        onPressed: () async {
                                          if (state is ReciveCodeLoading) {
                                            return;
                                          } else if (getCode.length == 5) {
                                            // setState(() {
                                            //   code = true;
                                            // });
                                            // _listenSmsCode();
                                            BlocProvider.of<RecivecodeBloc>(
                                                    context)
                                                .add(
                                              ReciveCodeButtonClicked(
                                                int.parse(
                                                  codeController.text,
                                                  // resiveCodeFrm.code.value,
                                                ),
                                              ),
                                            );
                                          } else {
                                            checkCode();
                                          }
                                        },
                                        child: state is ReciveCodeLoading
                                            ? const CupertinoActivityIndicator(
                                                color: Colors.white,
                                              )
                                            : const Text(
                                                'تایید',
                                                style: TextStyle(
                                                    fontFamily: 'IransansDn'),
                                              ),
                                      ),
                                    )
                                  : Container(),
                              code == true
                                  ? FutureBuilder<List<RegisterSmsData>>(
                                      future: getregistersmsvalidation(
                                          resiveCodeFrm.code.value),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text('');
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.hasData &&
                                              snapshot.data != null &&
                                              snapshot.data!.first.count == 1) {
                                            // if (snapshot.data!.first.count == 1)
                                            getdl();
                                            return Container();
                                          } else {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                              (timeStamp) {
                                                checkCode();
                                                code = false;
                                                setState(
                                                  () {},
                                                );
                                              },
                                            );

                                            return Container();
                                          }
                                        } else {
                                          return const Text('');
                                        }
                                      },
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
