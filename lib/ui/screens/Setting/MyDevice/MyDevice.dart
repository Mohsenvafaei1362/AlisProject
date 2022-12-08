import 'package:local_notification_flutter_project/ui/data/repo/my_device_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/MyDevice/bloc/my_device_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/Setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDevice extends StatefulWidget {
  const MyDevice({Key? key}) : super(key: key);

  @override
  State<MyDevice> createState() => _MyDeviceState();
}

class _MyDeviceState extends State<MyDevice> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<MyDeviceBloc>(
        create: (context) {
          final bloc = MyDeviceBloc(myDeviceRepository: myDeviceRepository);
          bloc.add(MyDeviceStarted());
          return bloc;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<MyDeviceBloc, MyDeviceState>(
              builder: (context, state) {
                if (state is MyDeviceSuccess) {
                  state.mydevice.first.model;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Settings(),
                                  ),
                                ),
                              );
                            },
                            child: const Icon(Icons.keyboard_arrow_right),
                          ),
                          const Text('دستگاه های من'),
                          const Icon(Icons.question_mark_rounded),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(32),
                      child: Text(
                        'دستگاه فعلی',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Device(),
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

class Device extends StatelessWidget {
  const Device({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(32),
      child: InkWell(
        onTap: () {
          Scaffold.of(context).showBottomSheet<void>(
            (BuildContext context) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.lightBlueAccent,
                ),
                height: size.height / 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/android.png',
                        width: 48,
                        height: 48,
                      ),
                      const Text(
                        'Galaxy A20',
                        style: TextStyle(color: Colors.black45),
                      ),
                      const Text(
                        'Android 11.0.0',
                        style: TextStyle(color: Colors.black45),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: BorderDirectional(
                                  bottom: BorderSide(color: Colors.white),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'آخرین ورود',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      'آنلاین',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: BorderDirectional(
                                  bottom: BorderSide(color: Colors.white),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'اولین ورود',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '1401/04/25',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: BorderDirectional(
                                  bottom: BorderSide(color: Colors.white),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'نسخه عالیس',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '0.0.1',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 8, 26, 8),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'آدرس IP',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '5.125.228.53',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Row(
          children: [
            Image.asset(
              'assets/images/android.png',
              width: 48,
              height: 48,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Galaxy A20'),
                Text(
                  'آنلاین',
                  style: TextStyle(color: Colors.blue[200]),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_left),
          ],
        ),
      ),
    );
  }
}
