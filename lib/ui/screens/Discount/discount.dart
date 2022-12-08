import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class Discount extends StatefulWidget {
  const Discount({Key? key}) : super(key: key);

  @override
  State<Discount> createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  @override
  void initState() {
    super.initState();
    //startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_right_alt_sharp),
                    ),
                    const SizedBox(width: 20),
                    const Text('کدهای تخفیف من'),
                  ],
                ),
              ),
              const Divider(
                height: 5,
              ),
              SizedBox(
                width: size.width,
                child: Image.asset(
                  'assets/images/discount.jpg',
                  width: size.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 35, 12, 0),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'عالیس',
                            style: TextStyle(color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'اعتبار : ',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'تا چهارشنبه 25 تیر'.toPersianDigit(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                      const ClipboardData(text: 'ABF5B'))
                                  .then(
                                (_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text("کد تخفیف کپی شد"),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 120,
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'کپی کنید',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                '30,000'.toPersianDigit(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const Text(
                                'تومان',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'حداقل',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '800000'.toPersianDigit(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'ریال خرید',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          SizedBox(
                            width: 120,
                            height: 35,
                            child: Center(
                              child: Text(
                                'ABF5B'.toPersianDigit(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
