import 'package:local_notification_flutter_project/ui/data/repo/my_orders_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/MyOrders/bloc/my_orders_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/complaintForm/complaint_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<MyOrdersBloc>(
        create: (context) {
          final bloc = MyOrdersBloc(myOrdersRepository: myOrdersRepository);
          bloc.add(MyOrdersStarted());
          return bloc;
        },
        child: SafeArea(
          child: BlocBuilder<MyOrdersBloc, MyOrdersState>(
            // buildWhen: (previous, current) {
            // return  current is MyOrdersError ||
            //       current is MyOrdersInitial ||
            //       current is MyOrdersLoading;
            // },
            builder: (context, state) {
              // if (state is MyOrdersSuccess) {
              return Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: size.width,
                        height: size.height * 0.06,
                        padding: const EdgeInsets.fromLTRB(0, 5, 20, 5),
                        // margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          // border: Border(
                          //   bottom: BorderSide(
                          //     color: Colors.black12,
                          //     width: 1,
                          //   ),
                          // ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(CupertinoIcons.arrow_right),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'سفارش های من',
                              style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DefaultTabController(
                        length: 2, // length of tabs
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const TabBar(
                              labelColor: Colors.green,
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Tab(text: 'سفارش های باز'),
                                Tab(text: 'سفارش های بسته'),
                              ],
                            ),
                            Container(
                              height: 400, //height of TabBarView
                              decoration: const BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Colors.grey, width: 0.5))),
                              child: TabBarView(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  'کد سفارش',
                                                  style: TextStyle(
                                                    fontFamily: 'IransansDn',
                                                    fontSize: 12,
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 32,
                                                ),
                                                Text(
                                                  '263012304'.toPersianDigit(),
                                                  style: const TextStyle(
                                                      fontFamily: 'IransansDn',
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              // crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                const Text(
                                                  'تاریخ سفارش',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'IransansDn',
                                                      color: Colors.black45),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  '1401/04/22'.toPersianDigit(),
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontFamily: 'IransansDn'),
                                                ),
                                                const SizedBox(width: 160),
                                                Text(
                                                  '50000 تومان'
                                                      .toPersianDigit(),
                                                  style: const TextStyle(
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'تاریخ تحویل',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'IransansDn',
                                                      color: Colors.black45),
                                                ),
                                                const SizedBox(
                                                  width: 22,
                                                ),
                                                Text(
                                                  '1401/04/28'.toPersianDigit(),
                                                  style: const TextStyle(
                                                      fontSize: 10),
                                                ),
                                                // Spacer(),
                                                // Spacer(),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: const [
                                                Text(
                                                  'نوع سفارش: ',
                                                  style: TextStyle(
                                                    color: Colors.black45,
                                                    fontFamily: 'IransansDn',
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('پرداخت در محل'),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: size.width * 0.5,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      // Get.to(const Buy4());
                                                    },
                                                    child: const Text(
                                                      'پیگیری سفارش',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'IransansDn'),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          Colors.blue.shade600,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.3,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // Get.to(const Buy3());
                                                    },
                                                    child: const Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      size: 15,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          // MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'کد سفارش',
                                              style: TextStyle(
                                                fontFamily: 'IransansDn',
                                                fontSize: 12,
                                                color: Colors.black45,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 22,
                                            ),
                                            Text(
                                              '263012305'.toPersianDigit(),
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            // SizedBox(
                                            //   width: 50,
                                            //   height: 20,
                                            // ),
                                            const Text(
                                              'تاریخ سفارش',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'IransansDn',
                                                  color: Colors.black45),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 10,
                                              ),
                                              child: Text(
                                                '1401/04/22'.toPersianDigit(),
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              '50000 تومان '.toPersianDigit(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'IransansDn'),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            // SizedBox(
                                            //   width: 50,
                                            // ),
                                            const Text(
                                              'تاریخ تحویل',
                                              style: TextStyle(
                                                  fontFamily: 'IransansDn',
                                                  fontSize: 12,
                                                  color: Colors.black45),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 14),
                                              child: Text(
                                                '1401/04/28'.toPersianDigit(),
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: const [
                                            // SizedBox(
                                            //   width: 50,
                                            // ),
                                            Text(
                                              'نوع سفارش: ',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontFamily: 'IransansDn'),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'پرداخت در محل',
                                              style: TextStyle(
                                                fontFamily: 'IransansDn',
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Directionality(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      child: AlertDialog(
                                                        title: const Text(
                                                          'با ثبت امتیاز خود، ما را در بالابردن کیفیت خدمت رسانی یاری فرمایید. با تشکر',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                        actions: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                      'سفارش'),
                                                                  const Spacer(),
                                                                  RatingBar
                                                                      .builder(
                                                                    initialRating:
                                                                        3,
                                                                    minRating:
                                                                        1,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    allowHalfRating:
                                                                        true,
                                                                    itemCount:
                                                                        5,
                                                                    itemPadding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            0.01),
                                                                    itemBuilder:
                                                                        (context,
                                                                                _) =>
                                                                            const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber,
                                                                    ),
                                                                    onRatingUpdate:
                                                                        (rating) {
                                                                      print(
                                                                          rating);
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                      'ویزیتور'),
                                                                  const Spacer(),
                                                                  RatingBar
                                                                      .builder(
                                                                    initialRating:
                                                                        3,
                                                                    minRating:
                                                                        1,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    allowHalfRating:
                                                                        true,
                                                                    itemCount:
                                                                        5,
                                                                    itemPadding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            0.01),
                                                                    itemBuilder:
                                                                        (context,
                                                                                _) =>
                                                                            const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber,
                                                                    ),
                                                                    onRatingUpdate:
                                                                        (rating) {
                                                                      print(
                                                                          rating);
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                      'پخش'),
                                                                  const Spacer(),
                                                                  RatingBar
                                                                      .builder(
                                                                    initialRating:
                                                                        3,
                                                                    minRating:
                                                                        1,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    allowHalfRating:
                                                                        true,
                                                                    itemCount:
                                                                        5,
                                                                    itemPadding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            0.01),
                                                                    itemBuilder:
                                                                        (context,
                                                                                _) =>
                                                                            const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber,
                                                                    ),
                                                                    onRatingUpdate:
                                                                        (rating) {
                                                                      print(
                                                                          rating);
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 25,
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: const Text(
                                                                    'ذخیره امتیاز'),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                width: size.width * 0.4,
                                                height: size.height * 0.05,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Center(
                                                  child: Text(
                                                    'ثبت امتیاز',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Directionality(
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            child:
                                                                ComplaintForm(),
                                                          )),
                                                );
                                              },
                                              child: Container(
                                                width: size.width * 0.2,
                                                height: size.height * 0.05,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Center(
                                                  child: Text(
                                                    'ثبت شکایت',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                // Get.to(const Buy3());
                                              },
                                              child: const Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 15,
                                                color: Colors.black45,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 30,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
              // } else if (state is MyOrdersLoading) {
              //   return const Center(
              //     child: CupertinoActivityIndicator(),
              //   );
              // } else if (state is MyOrdersError) {
              //   return Center(
              //     child: Text(state.exception.message),
              //   );
              // } else {
              //   throw Exception('state is not supported');
              // }
            },
          ),
        ),
      ),
    );
  }
}
