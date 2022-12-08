import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:local_notification_flutter_project/ui/screens/Notification/services/notification_service.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/auth_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/cart_repository.dart';
import 'package:local_notification_flutter_project/ui/models/DL/getdl_user.dart';
import 'package:local_notification_flutter_project/ui/root.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/home.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/RegisterScreen/register_screen.dart';
import 'package:local_notification_flutter_project/ui/screens/auth/GetSmsCodeLogin/get_sms_code_login.dart';
import 'package:local_notification_flutter_project/ui/screens/auth/bloc/auth_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:location/location.dart';
import 'package:local_notification_flutter_project/ui/screens/auth/local_Biometrics.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

final UiAddressIp getAddress2 = Get.put(UiAddressIp());

class _AuthScreenState extends State<AuthScreen> {
  final UiPhoneController phoneController = Get.put(UiPhoneController());
  final UiGetLocation getLocation = Get.put(UiGetLocation());
  final UiTimerUser timerUser = Get.put(UiTimerUser());

  final UiShowInfo showInfo = Get.put(UiShowInfo());
  final UiShowInfo showInfo2 = Get.put(UiShowInfo());
  final UiLog log = Get.put(UiLog());
  final UiTimeStep timeStep = Get.put(UiTimeStep());
  final UiDl _dl = Get.put(UiDl());

  final TextEditingController _controller = TextEditingController();

  var userMap = [];
  var urlstatus = Uri.parse(getAddress2.Get_url('statuse'));

  var urlfingerprint = Uri.parse(getAddress2.Get_url('checkvalue_fingerprint'));
  var urllog = Uri.parse(getAddress2.Get_url('log'));
  String? login;
  bool canResendCode = true;
  checkvalue_fingerprint() async {
    await http
        .post(
          urlfingerprint,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "fingerprint": log.fingerprint.value.toString(),
          }),
        )
        .then((response) =>
            showInfo2.data.value = jsonDecode(response.body) as List)
        .catchError((err) => print(err));

    Map<String, dynamic> map = {
      for (var item in showInfo2.data)
        item['fingerprint']: {
          'flag': showInfo2.flag1.value = item['flag'].toString(),
          'status': showInfo2.status.value = item['status'].toString(),
        }
    };

    if (showInfo2.data.length != 1) {
      login = 'false';
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Center(
            child: Text(
              '! توجه',
              style:
                  TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
            ),
          ),
          content: const Text(
            'اثر انگشت وارد شده صحیح نمی باشد',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.pink, fontSize: 12, fontFamily: 'IransansDn'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('متوجه شدم',
                  style: TextStyle(fontFamily: 'IransansDn')),
            ),
          ],
        ),
      );
    } else if (showInfo2.data.length == 1) {
      login = 'true';
    }
  }

  getLoc() async {
    var location = Location();
    return location.onLocationChanged.listen((currentLocation) {
      getLocation.lat.value = currentLocation.latitude!;
      getLocation.long.value = currentLocation.longitude!;
    });
  }

  Map<String, dynamic>? _info;
  String? id, brand, model, fingerprint;

  // This function is triggered when the floating button gets pressed
  _getInfo() async {
    // Instantiating the plugin
    final deviceInfoPlugin = DeviceInfoPlugin();

    final result = await deviceInfoPlugin.deviceInfo;
    log.id.value = jsonEncode(result.toMap()['id']);
    log.brand.value = jsonEncode(result.toMap()['brand']);
    log.model.value = jsonEncode(result.toMap()['model']);
    log.fingerprint.value = jsonEncode(result.toMap()['fingerprint']);
    setState(() {
      _info = result.toMap();
    });
    // print(_info);
  }

  StreamSubscription? streamSubscription;
  late bool isVerified;
  late BiometricsVerifier verifier;
  var intValue2 =
      Random().nextInt(999) + 10000; // Value is >= 10000 and < 10999.

  @override
  void initState() {
    super.initState();
    _getInfo();
    isVerified = false;
    verifier = BiometricsVerifier();
    NotificationService().init();
    // listenNotification();
  }

  // void listenNotification() => NotificationService().notificationDetails;
  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  final ThemeData themeData = ThemeData();
  static const onBackground = Colors.white;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final String data = Get.parameters.values.toString();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // drawer: NavBar(),
        backgroundColor: Colors.white,
        // appBar: AppBar(),
        body: BlocProvider<AuthBloc>(
          create: (context) {
            final bloc =
                AuthBloc(authRepository, cartRepository: cartRepository);
            streamSubscription = bloc.stream.listen(
              (state) async {
                if (state is AuthSuccess) {
                  if (state.authInfo.length == 1) {
                    var dl = await getdlUser(state.authInfo.first.dlRef);
                    if (dl.length == 1 && dl.first.DlState == 2) {
                      // Get.to(
                      //   () => Directionality(
                      //     textDirection: TextDirection.rtl,
                      //     child: GetSmsCode(
                      //       onChanged: (value) {},
                      //       timeout: 120,
                      //     ),
                      //   ),
                      // );
                      Get.to(
                        () => const Directionality(
                          textDirection: TextDirection.rtl,
                          child: RootScreen(),
                        ),
                      );
                    } else {
                      Get.defaultDialog(
                        title: '! کاربر گرامی',
                        titleStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                        // textConfirm: 'ok',
                        textCancel: 'متوجه شدم',
                        middleText: '.شما مجوز ورود ندارید',
                      );
                    }
                  }

                  // Navigator.of(context).pop();
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.appException.message),
                    ),
                  );
                }
              },
            );
            // bloc.add(AuthStarted());
            return bloc;
          },
          child: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: BlocBuilder<AuthBloc, AuthState>(
                // buildWhen: (previous, current) {
                //   return current is AuthLoading ||
                //       current is AuthInitial ||
                //       current is AuthError;
                // },
                builder: (context, state) {
                  //   if (state is AuthSuccess) {
                  //      if (state.authInfo.length == 1){
                  //   var dl = await getdl(state.authInfo.first.DlRef);
                  //   if (dl.length == 1 && dl.first.DlState == 2) {
                  //     Get.to(() => RootScreen());
                  //   } else {
                  //     Get.defaultDialog(title: 'شما مجوز ورود ندارید');
                  //   }
                  // }}
                  // if (state is AuthInitial) {
                  return Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/Capture3.PNG',
                              width: size.width / 2,
                            ),
                            const Text(
                              'مرکز فروشندگان عالیس',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue),
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(32, 0, 32, 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Form(
                                      key: phoneController.loginFormKey,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            inputFormatters: const [],
                                            style: const TextStyle(
                                              fontFamily: 'IransansDn',
                                            ),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              labelText: "کد مشتری/تلفن همراه",
                                              prefixIcon: const Icon(
                                                  Icons.mobile_friendly),
                                            ),
                                            // keyboardType: TextInputType.number,
                                            controller:
                                                phoneController.phoneController,
                                            onSaved: (value) {
                                              phoneController.phone.value =
                                                  value!.toPersianDigit();
                                            },
                                            validator: (value) {
                                              return phoneController
                                                  .validatePhone(value!);
                                            },
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            obscureText: true,
                                            inputFormatters: const [],
                                            style: const TextStyle(
                                              fontFamily: 'IransansDn',
                                            ),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              labelText: "رمز عبور",
                                              prefixIcon: const Icon(
                                                  Icons.key_outlined),
                                            ),
                                            controller: phoneController
                                                .passwordController,
                                            onSaved: (value) {
                                              phoneController.password.value =
                                                  value!.toPersianDigit();
                                            },
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 15, top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  Colors.blueAccent,
                                              minimumSize: Size(
                                                  size.width / 1.6,
                                                  size.height * 0.06),
                                            ),
                                            onPressed: () {
                                              phoneController.phone.value =
                                                  phoneController
                                                      .phoneController.text;
                                              phoneController.password.value =
                                                  phoneController
                                                      .passwordController.text;
                                              state is AuthLoading
                                                  ? null
                                                  : BlocProvider.of<AuthBloc>(
                                                          context)
                                                      .add(
                                                      AuthButtonLoginIsClicked(
                                                        phoneController
                                                            .phoneController
                                                            .text,
                                                        phoneController
                                                            .passwordController
                                                            .text,
                                                      ),
                                                    );
                                              // authRepository.login(
                                              //   phoneController
                                              //       .phoneController.text,
                                              //   phoneController
                                              //       .passwordController.text,
                                              // );
                                              // getInfoPHone();
                                            },
                                            child: state is AuthLoading
                                                ? const CupertinoActivityIndicator(
                                                    color: Colors.white,
                                                  )
                                                : const Text(
                                                    'ادامه',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'IransansDn'),
                                                  ),
                                          ),
                                          isVerified
                                              ? TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isVerified = true;
                                                    });
                                                  },
                                                  child:
                                                      checkvalue_fingerprint())
                                              : InkWell(
                                                  onTap: () async {
                                                    // checkvalue_fingerprint();
                                                    try {
                                                      await verifier
                                                          .verifyBiometrics(
                                                              'حسگر را لمس کنید');
                                                      // ---- Add your logic after finger print verification here
                                                      // ---
                                                      // ---
                                                      setState(() {
                                                        isVerified = true;
                                                      });
                                                    } catch (e) {
                                                      // ---- Verification Failed
                                                      showDialog(
                                                        context: context,
                                                        builder: (c) =>
                                                            AlertDialog(
                                                          content: Text(
                                                            e.toString(),
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'IransansDn'),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                'خروج از برنامه',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'IransansDn'),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    height: size.height * 0.06,
                                                    width: size.width * 0.20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: const Icon(
                                                      Icons.fingerprint,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'هنوز ثبت نام نکرده اید؟',
                            style: TextStyle(color: Colors.black45),
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: RegisterScreen(
                                      onChanged: (value) {},
                                      timeout: timeStep.timestep.value,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'همین حالا ثبت نام کنید',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                  // } else if (state is AuthLoading) {
                  //   return const Center(
                  //     child: CupertinoActivityIndicator(),
                  //   );
                  // } else if (state is AuthError) {
                  //   return Center(
                  //     child: Text(state.appException.message),
                  //   );
                  // } else {
                  //   throw Exception('state in not supported');
                  // }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
