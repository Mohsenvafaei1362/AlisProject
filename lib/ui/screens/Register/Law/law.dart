import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/lawRepository.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Law/bloc/law_screen_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Law extends StatefulWidget {
  const Law({Key? key}) : super(key: key);

  @override
  State<Law> createState() => _LawState();
}

class _LawState extends State<Law> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool cansave = false;
  bool isClickedButton = false;

  final UiConst _const = Get.put(UiConst());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<LawScreenBloc>(
        create: (context) {
          final bloc = LawScreenBloc(lawScreenRepository);
          bloc.add(LawScreenStarted());
          return bloc;
        },
        child: SafeArea(
          child: BlocBuilder<LawScreenBloc, LawScreenState>(
            builder: (context, state) {
              return WillPopScope(
                onWillPop: () {
                  //we need to return a future
                  return Future.value(false);
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            _const.ConstTitle.value,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(32),
                      width: size.width * 0.8,
                      height: size.height * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Text(
                        _const.ConstDesc.value,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.black87,
                          height: 2.5,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'شرایط و قوانین برنامه ',
                            style: TextStyle(fontSize: 17.0),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () {
                              state is LawScreenLoading
                                  ? null
                                  : BlocProvider.of<LawScreenBloc>(context)
                                      .add(const LawScreenClickButton());
                              // isClickedButton
                              //     ? print('غیر مجاز ')
                              //     : BlocProvider.of<LawScreenBloc>(context).add(
                              //         const LawScreenClickButton(2, '2', 'Loginfour'));
                              // // : putregistermemberlevel(2, '2', 'Loginfour');
                              // isClickedButton = true;
                              // checkvalue();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const Directionality(
                              //       textDirection: TextDirection.rtl,
                              //       child: LoginFour(),
                              //     ),
                              //   ),
                              // );
                            },
                            child: Container(
                              width: size.width * 0.3,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: state is LawScreenLoading
                                  ? const CupertinoActivityIndicator()
                                  : const Center(
                                      child: Text(
                                        'قبول میکنم  >',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                            ),
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
      ),
    );
  }
}
