import 'dart:async';
import 'dart:io';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Congratulation_repository.dart';
import 'package:local_notification_flutter_project/ui/root.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/home.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Confirmation/confirmation.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Congratulation/bloc/congratulation_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/About/About.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Congratulation extends StatefulWidget {
  const Congratulation({Key? key}) : super(key: key);

  @override
  State<Congratulation> createState() => _CongratulationState();
}

class _CongratulationState extends State<Congratulation> {
  final UiTimerUser timerUser = Get.put(UiTimerUser());
  // final UiFlag flag = Get.put(UiFlag());

  @override
  void initState() {
    super.initState();
    //startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription?.cancel();
  }

  StreamSubscription? streamSubscription;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // ),
      backgroundColor: Colors.white,
      body: BlocProvider<CongratulationBloc>(
        create: (context) {
          final bloc = CongratulationBloc(
            congratulationRepository: congratulationRepository,
          );
          bloc.add(CongratulationStarted());
          streamSubscription = bloc.stream.listen(
            (state) {
              if (state is CongratulationSuccess) {
                // if (state.isActive == 2) {
                //   Get.to(const Directionality(
                //       textDirection: TextDirection.rtl, child: RootScreen()));
                // } else {
                //   print(state.isActive);
                // }
              }
            },
          );
          return bloc;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<CongratulationBloc, CongratulationState>(
              builder: (context, state) {
                return SizedBox(
                  width: size.width,
                  child: WillPopScope(
                    onWillPop: () {
                      exit(0);
                      return Future.value(false);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: size.width,
                          height: size.height / 2.5,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/2085.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const Text(
                          'تبریک!',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          '.اکنون شما به جمع خانواده عالیس پیوستید',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const Text('!از تجارت آنلاین لذت ببرید',
                            style: TextStyle(color: Colors.black54)),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'پس از ورود به داشبورد پنل همکاران عالیس، با ورود به صفحه پروفایل شما می توانید نسخه آنلاین قرارداد خود را مشاهده کنید. لطفا توجه کنید که نیازی به چاپ و ارسال قرارداد نیست',
                                textAlign: TextAlign.justify,
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: AboutScreen(),
                                ),
                              ),
                            );
                          },
                          child: const Text('آشنایی با گروه عالیس'),
                        ),
                        // TextButton(
                        //   onPressed: () {
                        //     state is CongratulationLoading
                        //         ? null
                        //         : BlocProvider.of<CongratulationBloc>(context)
                        //             .add(
                        //             CongratulationButtonClicked(),
                        //           );
                        //   },
                        //   child: state is CongratulationLoading
                        //       ? const CupertinoActivityIndicator()
                        //       : const Text('مشاهده مراحل تایید مدارک'),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
