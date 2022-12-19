import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/Club_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/Ghole_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/message_box_info.dart';
import 'package:local_notification_flutter_project/ui/data/repo/auth_repository.dart';
import 'package:local_notification_flutter_project/ui/models/Comment/comment.dart';
import 'package:local_notification_flutter_project/ui/screens/CommentSuggest/Comment.dart';
import 'package:local_notification_flutter_project/ui/screens/CustomerClub/CustomerClub.dart';
import 'package:local_notification_flutter_project/ui/screens/Discount/discount.dart';
import 'package:local_notification_flutter_project/ui/screens/Friends/Friends.dart';
import 'package:local_notification_flutter_project/ui/screens/Ghole/ghole.dart';
import 'package:local_notification_flutter_project/ui/screens/MessageBox/message_box.dart';
import 'package:local_notification_flutter_project/ui/screens/MyOrders/my_orders.dart';
import 'package:local_notification_flutter_project/ui/screens/Profile/profile.dart';
import 'package:local_notification_flutter_project/ui/screens/ProgressPath/progress_path.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/BankAccount/BankAccount.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/Setting.dart';
import 'package:local_notification_flutter_project/ui/screens/Support/support.dart';
import 'package:local_notification_flutter_project/ui/screens/TransactionList/transaction_list.dart';
import 'package:local_notification_flutter_project/ui/screens/complaintForm/complaint_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({
    key,
    required this.club,
    required this.ghole,
    required this.messageCount,
  });
  final List<ClubInfo> club;
  final List<GholeInfo> ghole;
  final List<MessageCount> messageCount;
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final UiShowInfo showInfo = Get.put(UiShowInfo());
  final UiTimerUser timerUser = Get.put(UiTimerUser());
  // final UiFlag flag = Get.put(UiFlag());
  Map map = {1: 'one', 2: 'two', 3: 'three'};
  final UiDl _dl = Get.put(UiDl());
  // const NavBar({Key? key}) : super(key: key);
  final List<String> items = <String>[
    'مسیر پیشرفت',
    'باشگاه من',
    'تراکنش های من',
  ];

  String? selectedValue;
  bool isHovering = false;

  @override
  void initState() {
    super.initState();
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
    exit(0);
    // return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Uint8List _avatarImage = base64.decode(_dl.Avatar.value);
    Uint8List _avatarLevel = base64.decode(widget.ghole.first.Avatar);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Row(
              children: [
                // Text('فرهاد رضوانی'),
                Text(_dl.FName.value + ' ' + _dl.LName.value),
                // Text('${showInfo.data.map((e) => e['full_name'])}'),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'امتیاز شما : ${widget.club.first.Value}'.toPersianDigit(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            accountEmail: Row(
              children: [
                Text(showInfo.phone.value.toPersianDigit()),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    showInfo.nagsh.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),
            currentAccountPicture: CircleAvatar(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.memory(
                      _avatarImage,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  // const ClipOval(
                  //   child: Icon(
                  //     CupertinoIcons.person_crop_circle_fill,
                  //     size: 70,
                  //   ),
                  // ),
                  Positioned(
                    top: -15,
                    right: -15,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Directionality(
                              textDirection: TextDirection.rtl,
                              child: Ghole(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        // height: size.height * 0.7,
                        // margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        // padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.memory(
                                _avatarLevel,
                                width: 30,
                                height: 30,
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
            decoration: const BoxDecoration(
              color: Colors.blue,
              // image: DecorationImage(
              //   image: AssetImage('assets/images/background.jpg'),
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_rounded),
            title: const Text('پروفایل'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: Profile(),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('صندوق پیام ها'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Directionality(
                    textDirection: TextDirection.rtl,
                    child: MessageBox(),
                  ),
                ),
              );
            },
            trailing: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  widget.messageCount.length.toString().toPersianDigit(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('مرکز پشتیبانی'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Directionality(
                    textDirection: TextDirection.rtl,
                    child: Support(),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopify_rounded),
            title: const Text('سفارش های من'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Directionality(
                      textDirection: TextDirection.rtl, child: MyOrders()),
                ),
              );
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.people),
            title: const Text(
              'باشگاه مشتریان',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                // color: Theme.of(context).hintColor,
              ),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 50, 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Directionality(
                                textDirection: TextDirection.rtl,
                                child: ProgressPath(),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: const [
                            Text(
                              'مسیر پیشرفت',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                // color: Theme.of(context).hintColor,
                              ),
                            ),
                            // Spacer(),
                            // Icon(
                            //   Icons.keyboard_arrow_left_rounded,
                            //   color: Colors.lightBlue,
                            // ),
                            // SizedBox(width: 15),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: CustomerClub(),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: const [
                            Text(
                              'باشگاه من',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                // color: Theme.of(context).hintColor,
                              ),
                            ),
                            // Spacer(),
                            // Icon(
                            //   Icons.keyboard_arrow_left_rounded,
                            //   color: Colors.lightBlue,
                            // ),
                            // SizedBox(width: 15),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Directionality(
                                textDirection: TextDirection.rtl,
                                child: TransactionList(),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: const [
                            Text(
                              'لیست تراکنش ها',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                // color: Theme.of(context).hintColor,
                              ),
                            ),
                            // Spacer(),
                            // Icon(
                            //   Icons.keyboard_arrow_left_rounded,
                            //   color: Colors.lightBlue,
                            // ),
                            // SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.share_rounded),
            title: const Text('دعوت از دوستان'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Directionality(
                    textDirection: TextDirection.rtl,
                    child: Friends(),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat_rounded),
            title: const Text('شکایت مشتری'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Directionality(
                    textDirection: TextDirection.rtl,
                    child: ComplaintForm(),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.square_list_fill),
            title: const Text('نظر سنجی'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Directionality(
                    textDirection: TextDirection.rtl,
                    child: CommentScreen(),
                  ),
                ),
              );
            },
          ),
          const Divider(
            color: Colors.black12,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('تنظیمات'),
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
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('خدمات تخفیف'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Directionality(
                    textDirection: TextDirection.rtl,
                    child: Discount(),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('معرفی حساب بانکی'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Directionality(
                    textDirection: TextDirection.ltr,
                    child: BankAccount(),
                  ),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.movie),
          //   title: const Text('آموزش همکاران'),
          //   onTap: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(
          //     //     builder: (context) => const Directionality(
          //     //       textDirection: TextDirection.rtl,
          //     //       child: Settings_ATM(),
          //     //     ),
          //     //   ),
          //     // );
          //   },
          // ),
          const Divider(
            color: Colors.black12,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('خروج'),
            onTap: () {
              onWillPop();
              // exit(0);
              // authRepository.singOut();
              // SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
