import 'dart:async';
import 'dart:convert';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Club_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Ghole_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/auth_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/cart_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/customer_club_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/message_box_repository.dart';
import 'package:local_notification_flutter_project/ui/root.dart';
import 'package:local_notification_flutter_project/ui/screens/Profile/bloc/profile_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/Setting.dart';
import 'package:local_notification_flutter_project/ui/screens/TransactionList/transaction_list.dart';
import 'package:local_notification_flutter_project/ui/screens/TransactionList/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/screens/auth/auth.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/empty_state.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UiShowInfo showInfo = Get.put(UiShowInfo());
  final UiTimerUser timerUser = Get.put(UiTimerUser());
  // final UiFlag flag = Get.put(UiFlag());
  final UiDl _dl = Get.put(UiDl());

  StreamSubscription? streamSubscription;
  ProfileBloc? profileBloc;
  @override
  void initState() {
    super.initState();
    AuthRepository.authChangeNotifire.addListener(authChangeNotifireListener);
  }

  void authChangeNotifireListener() {
    profileBloc?.add(
      ProfileChanged(AuthRepository.authChangeNotifire.value),
    );
  }

  @override
  void dispose() {
    super.dispose();
    profileBloc?.close();
  }

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        backgroundColor: Color.fromARGB(255, 231, 190, 129),
        textColor: Colors.black,
        msg: 'برای خروج دوباره کلیک کنید',
      );
      return Future.value(false);
    }
    await authRepository.singOut();
    CartRepository.cartItemCountNotifier.value = '0';
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Uint8List _avatarImage = base64.decode(_dl.Avatar.value);
    // final user = AllUsers.users;
    return BlocProvider<ProfileBloc>(
      create: (context) {
        final bloc = ProfileBloc(
          clubRepository: clubRepository,
          gholeRepository: gholeRepository,
          messageBoxRepository: messageBoxRepository,
        );
        bloc.add(ProfileStarted(AuthRepository.authChangeNotifire.value!));
        // streamSubscription = bloc.stream.listen((state) {
        //   if (state is ProfileSuccess) {
        //   } else if (state is ProfileLoading) {
        //     const Center(
        //       child: CupertinoActivityIndicator(),
        //     );
        //   } else if (state is ProfileError) {
        //     Center(
        //       child: Text(state.exception.message),
        //     );
        //   } else {
        //     throw Exception('state is not supported');
        //   }
        // });
        profileBloc = bloc;
        return bloc;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<ProfileBloc, ProfileState>(
            // buildWhen: (previous, current) {
            //   return current is ProfileError ||
            //       current is CustomerClubInitial ||
            //       current is ProfileLoading;
            // },
            builder: (context, state) {
              if (state is ProfileSuccess) {
                return SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height * 0.8,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                height: size.height * 0.1,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                  color: Colors.blue,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipOval(
                                      child: Image.memory(
                                        _avatarImage,
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      ' امتیاز شما : ${state.club.first.Value}'
                                          .toPersianDigit(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 24, 24, 0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Wallet(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(children: [
                                    Image.asset(
                                      'assets/icons/wallet.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const Text('موجودی حساب'),
                                    const Spacer(),
                                    const Text('10'),
                                    Image.asset(
                                      'assets/icons/tom.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ]),
                                ),
                              ),
                              Container(
                                width: size.width,

                                padding:
                                    const EdgeInsets.fromLTRB(32, 15, 32, 15),
                                // color: Colors.red,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'اطلاعات شخصی',
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                    const Divider(),
                                    Text(
                                      'نام و نام خانوادگی :  ${_dl.FName.value} ${_dl.LName.value}',
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    // Text(
                                    //   'نام خانوادگی :  ${user[1].lname}',
                                    //   style: TextStyle(
                                    //     color: Colors.black87,
                                    //     fontSize: 15,
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          ' ایمیل : ',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          _dl.Email.value,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'شماره تلفن :  ${_dl.PhoneNumber.value}'
                                          .toPersianDigit(),
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Divider(
                                      height: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Settings()),
                                          );
                                          // Get.to(
                                          //   () => Directionality(
                                          //     textDirection: TextDirection.rtl,
                                          //     child: Settings(),
                                          //   ),
                                          // );
                                        },
                                        child: Row(children: [
                                          Image.asset(
                                            'assets/icons/settings.png',
                                            width: 48,
                                            height: 48,
                                          ),
                                          const SizedBox(width: 20),
                                          const Text('تنظیمات'),
                                          const Spacer(),
                                          const Icon(Icons.keyboard_arrow_left),
                                        ]),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: InkWell(
                                        onTap: () {
                                          // Get.to(
                                          //   const Directionality(
                                          //     textDirection: TextDirection.rtl,
                                          //     child: Buy(),
                                          //   ),
                                          // );
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/icons/shopping-cart.png',
                                              width: 48,
                                              height: 48,
                                            ),
                                            const SizedBox(width: 20),
                                            const Text('سفارش های من'),
                                            const Spacer(),
                                            const Icon(
                                                Icons.keyboard_arrow_left),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(
                                            const Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: TransactionList(),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/icons/wallet20.png',
                                              width: 48,
                                              height: 48,
                                            ),
                                            const SizedBox(width: 20),
                                            const Text('پرداخت های من'),
                                            const Spacer(),
                                            const Icon(
                                                Icons.keyboard_arrow_left),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.06,
                              child: Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                    onPrimary: Colors.black,
                                    minimumSize: size * 0.9,
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'ویرایش اطلاعات',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: size.height * 0.06,
                              child: Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                    onPrimary: Colors.black,
                                    minimumSize: size * 0.9,
                                  ),
                                  onPressed: () {
                                    onWillPop();
                                  },
                                  child: const Text(
                                    'خروج از حساب کاربری',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is ProfileRequired) {
                return EmptyView(
                  message:
                      'برای مشاهده پروفایل ابتدا وارد حساب کاربری خود شوید',
                  callToAction: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                        CupertinoPageRoute<bool>(
                          fullscreenDialog: true,
                          builder: (BuildContext context) => Directionality(
                            textDirection: TextDirection.rtl,
                            child: AuthScreen(),
                          ),
                        ),
                      );
                    },
                    child: const Text('ورود به حساب کاربری'),
                  ),
                  image: Image.asset('assets/images/1234.jpg'),
                );
              } else if (state is ProfileLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state is ProfileError) {
                return Center(
                  child: Text(
                    state.exception.message,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[200],
                      fontSize: 18,
                    ),
                  ),
                );
              } else {
                throw Exception('state is not supported');
              }
            },
          ),
        ),
      ),
    );
  }
}
