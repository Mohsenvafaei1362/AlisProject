import 'package:local_notification_flutter_project/ui/screens/Ghole/introducing_ghole.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class Ghole extends StatefulWidget {
  const Ghole({Key? key}) : super(key: key);

  @override
  State<Ghole> createState() => _GholeState();
}

class _GholeState extends State<Ghole> {
  @override
  void initState() {
    super.initState();
    //startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Listener(
      onPointerDown: (event) {},
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.keyboard_arrow_right),
                      ),
                      const Text('قله ی من'),
                      const Icon(Icons.question_mark_rounded),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: size.width,
                  height: size.height * 0.3,
                  child: Image.asset(
                    'assets/images/9800.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('قله:',
                              style: TextStyle(color: Colors.black45)),
                          Text(
                            'سهند - سطح 5'.toPersianDigit(),
                            style: const TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('مجموع ریال:',
                              style: TextStyle(color: Colors.black45)),
                          Text('33,494'.toPersianDigit(),
                              style: const TextStyle(color: Colors.black45)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('مجموع ریال کسب شده امروز:',
                              style: TextStyle(color: Colors.black45)),
                          Text('0'.toPersianDigit(),
                              style: const TextStyle(color: Colors.black45)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('مجموع امتیاز:',
                              style: TextStyle(color: Colors.black45)),
                          Text('26,569'.toPersianDigit(),
                              style: const TextStyle(color: Colors.black45)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('مجموع امتیاز کسب شده امروز:',
                              style: TextStyle(color: Colors.black45)),
                          Text('0'.toPersianDigit(),
                              style: const TextStyle(color: Colors.black45)),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width / 2.5,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'وام های قرض الحسنه',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 2.5,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'بسته های اعتباری',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                            const Directionality(
                              textDirection: TextDirection.rtl,
                              child: Introducing_Ghole(),
                            ),
                          );
                        },
                        child: Container(
                          width: size.width / 2.5,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'آموزش',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 2.5,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'مسابقات',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Introducing_Ghole(),
                                    )),
                          );
                        },
                        child: Container(
                          width: size.width * 0.8,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'مسیر پیشرفت',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.3,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            'لیست تراکنش ها',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.black12,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'کسب 5 امتیاز از شرکت در مسابقه',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'دریافت امتیاز',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'کسب 10 امتیاز جهت معرفی مشتری',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'دریافت امتیاز',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'کسر 15 امتیاز جهت انتقال به حساب',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'پرداخت امتیاز',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: SizedBox(
                    width: size.width * 0.9,
                    height: size.height * 0.06,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'تبدیل امتیاز به وجه',
                        style: TextStyle(fontFamily: 'IransansDn'),
                      ),
                    ),
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
