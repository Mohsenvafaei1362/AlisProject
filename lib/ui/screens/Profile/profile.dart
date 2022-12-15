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
import 'package:local_notification_flutter_project/ui/screens/Favorite/favorite.dart';
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
import 'package:local_notification_flutter_project/ui/screens/widgets/pricelable.dart';
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
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(30),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 1,
                                  offset: Offset(0, 0),
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 18, left: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipOval(
                                  child: Image.memory(
                                    _avatarImage,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                Text(
                                  ' امتیاز شما : ${state.club.first.Value}'
                                      .toPersianDigit(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: size.width,
                          // color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16, left: 16),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/wallet.png',
                                  width: 35,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'موجودی حساب',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(240000.withPriceLable.toPersianDigit()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: size.width,
                          // color: Colors.blue,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Text(
                                  'اطلاعات شخصی',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 2,
                              ),
                              Rich_text(
                                dl: _dl,
                                title: 'نام و نام خانوادگی : ',
                                value: ' ${_dl.FName.value} ${_dl.LName.value}',
                              ),
                              Rich_text(
                                dl: _dl,
                                title: 'ایمیل : ',
                                value: ' ${_dl.Email} ',
                              ),
                              Rich_text(
                                dl: _dl,
                                title: 'تلفن : ',
                                value: ' ${_dl.PhoneNumber}'.toPersianDigit(),
                              ),
                              Divider(
                                height: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: size.width,
                          // color: Colors.green,
                          child: Column(
                            children: [
                              MenuItems(
                                press: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => Settings()),
                                  );
                                },
                                image: 'assets/icons/settings.png',
                                title: 'تنظیمات',
                              ),
                              MenuItems(
                                press: () {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //       builder: (context) => Settings()),
                                  // );
                                },
                                image: 'assets/icons/shopping-cart.png',
                                title: 'سفارش های من',
                              ),
                              MenuItems(
                                press: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TransactionList()),
                                  );
                                },
                                image: 'assets/icons/wallet20.png',
                                title: 'پرداخت های من',
                              ),
                              MenuItems(
                                press: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => FavoriteList()),
                                  );
                                },
                                image: 'assets/icons/wallet20.png',
                                title: 'لیست علاقه مندی های من',
                              ),
                              Divider(
                                height: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: size.width,
                          // color: Colors.grey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: size.width * 0.4,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 2,
                                    backgroundColor: Colors.amber[200],
                                    onPrimary: Colors.black,
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
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: size.width * 0.4,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 2,
                                    backgroundColor: Colors.pink[200],
                                    onPrimary: Colors.black,
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
                            ],
                          ),
                        ),
                      ),
                    ],
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

class MenuItems extends StatelessWidget {
  const MenuItems({
    Key? key,
    required this.press,
    required this.image,
    required this.title,
  }) : super(key: key);
  final GestureTapCallback press;
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 7, 16, 7),
      child: InkWell(
        onTap: press,
        child: Row(children: [
          Image.asset(
            image,
            width: 48,
            height: 48,
          ),
          const SizedBox(width: 20),
          Text(title),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_left),
        ]),
      ),
    );
  }
}

class Rich_text extends StatelessWidget {
  const Rich_text({
    Key? key,
    required UiDl dl,
    required this.title,
    required this.value,
  })  : _dl = dl,
        super(key: key);

  final UiDl _dl;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: RichText(
        text: TextSpan(
            text: title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 12,
            ),
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            ]),
      ),
    );
  }
}
