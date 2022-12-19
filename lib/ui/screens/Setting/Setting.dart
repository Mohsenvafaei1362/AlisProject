import 'package:local_notification_flutter_project/ui/screens/Home/home.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/About/About.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/BankAccount/BankAccount.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/ChangePassword/ChangePassword.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/MyDevice/MyDevice.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/MyStore/MyStore.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/Partners/Partners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// final ShowInfo3 showInfo = Get.put(ShowInfo3());

// final PhoneController phoneController = Get.put(PhoneController());

// var urltoggel = Uri.parse(getAddress2.Get_url('toggle_fingerprint'));

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // final int isSwitched = 1;
  bool farhad = true;
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.keyboard_arrow_right),
                      ),
                      const Icon(Icons.question_mark_rounded),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.11,
                  child: Image.asset(
                    'assets/images/setting.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20, right: 15),
                            child: Text(
                              'تنظیمات',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.07,
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.fingerprint,
                                  color: Colors.black54,
                                  size: 28,
                                ),
                                // Image.asset(
                                //   'assets/icons/lock.png',
                                //   width: 25,
                                // ),
                                const SizedBox(
                                  width: 30,
                                ),
                                const Text('ورود با اثر انگشت'),
                                const Spacer(),
                                StatefulBuilder(
                                  builder: (BuildContext context, setState) =>
                                      Switch(
                                    onChanged: (bool v) {
                                      setState(() => isSwitched = v);
                                    },
                                    value: isSwitched,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ListItems(
                        size: size,
                        title: 'تغییر رمز عبور',
                        image: 'assets/icons/key (1).png',
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Directionality(
                                textDirection: TextDirection.rtl,
                                child: ChangePassword(),
                              ),
                            ),
                          );
                        },
                      ),
                      ListItems(
                        size: size,
                        title: 'دستگاه های من',
                        image: 'assets/images/phone-message.png',
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Directionality(
                                textDirection: TextDirection.rtl,
                                child: MyDevice(),
                              ),
                            ),
                          );
                        },
                      ),
                      ListItems(
                        size: size,
                        title: 'فروشگاه های من',
                        image: 'assets/images/shop.png',
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: MyStore(),
                              ),
                            ),
                          );
                        },
                      ),
                      ListItems(
                        size: size,
                        title: 'همکاران من',
                        image: 'assets/icons/share.png',
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Directionality(
                                textDirection: TextDirection.rtl,
                                child: Partners(),
                              ),
                            ),
                          );
                        },
                      ),
                      ListItems(
                        size: size,
                        title: 'معرفی حساب بانکی',
                        image: 'assets/icons/savings.png',
                        press: () {
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
                      ListItems(
                        size: size,
                        title: 'درباره ما',
                        image: 'assets/icons/group.png',
                        press: () {
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
                      ),
                      const Center(
                        child: Text(
                          'Version 0.0.1',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({
    Key? key,
    required this.size,
    required this.title,
    required this.image,
    required this.press,
  }) : super(key: key);

  final Size size;
  final String title, image;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height * 0.07,
      // decoration: BoxDecoration(
      //   color: Colors.red,
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            InkWell(
              onTap: press,
              child: Row(
                children: [
                  Image.asset(
                    image,
                    width: 25,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(title),
                  const Spacer(),
                  const Icon(
                    CupertinoIcons.chevron_back,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
