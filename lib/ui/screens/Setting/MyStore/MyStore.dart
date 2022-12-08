import 'package:local_notification_flutter_project/ui/data/repo/my_store_repository.dart';
import 'package:local_notification_flutter_project/ui/models/data_settings_store.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/MyStore/bloc/my_store_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/NewStore/new_store.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/Personnel/personnel.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/pricelable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MyStore extends StatefulWidget {
  @override
  State<MyStore> createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  final List<String> items = [
    'شعبه اصلی',
    'شعبه جدید',
  ];
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    //startTimer();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Product7 = AllProducts7.products7;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: const [
            Text(
              'ثبت فروشگاه جدید',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Icon(Icons.add),
          ],
        ),
        // child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const NewStore(
                    active: false,
                    number: 1,
                  )));
        },
      ),
      body: BlocProvider<MyStoreBloc>(
        create: (context) {
          final bloc = MyStoreBloc(myStoreRepository: myStoreRepository);
          bloc.add(MyStoreStarted());
          return bloc;
        },
        child: SafeArea(
          child: SingleChildScrollView(
              child: BlocBuilder<MyStoreBloc, MyStoreState>(
            builder: (context, state) {
              // if (state is MyStoreSuccess) {
              //   // state.mystore.first.ConditionBuy;
              // } else if (state is MyStoreLoading) {
              //   const Center(
              //     child: CupertinoActivityIndicator(),
              //   );
              // } else if (state is MyStoreError) {
              //   Center(
              //     child: Text(state.exception.message),
              //   );
              // } else {
              //   throw Exception('state is not supported');
              // }
              return Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.07,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //  Icon(Icons.keyboard_arrow_right),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.keyboard_arrow_right),
                        ),
                        const Text('فروشگاه های من'),
                        const Icon(Icons.question_mark_rounded),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Container(
                        width: double.infinity,
                        height: size.height * 0.5,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Colors.lightBlueAccent,
                        ),
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            final data = Product7[0];
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/shop.png',
                                    width: 48,
                                    height: 48,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    data.title,
                                    style:
                                        const TextStyle(color: Colors.black45),
                                  ),
                                  // Text(
                                  //   'فعال',
                                  //   style: TextStyle(color: Colors.black45),
                                  // ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            24, 8, 24, 8),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: BorderDirectional(
                                              bottom: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  data.title3,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  data.title4,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            24, 8, 24, 8),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: BorderDirectional(
                                              bottom: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  data.title5,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  '${data.price}'
                                                      .toPersianDigit(),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            24, 8, 24, 8),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: BorderDirectional(
                                              bottom: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  data.title6,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  data.title7.toPersianDigit(),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            24, 8, 26, 8),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.title8,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                data.title9.toPersianDigit(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                      //   },
                      // );
                    },
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            BottomSheet(context, size, Product7, 0, 0);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(top: 40),
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/shop.png',
                                  width: 48,
                                  height: 48,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Product7[0].title,
                                    ),
                                    Text(
                                      Product7[0].title2,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.keyboard_arrow_left),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            BottomSheet(context, size, Product7, 1, 1);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/shop.png',
                                  width: 48,
                                  height: 48,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Product7[1].title,
                                    ),
                                    Text(
                                      Product7[1].title2,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.keyboard_arrow_left),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            BottomSheet(context, size, Product7, 2, 2);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/shop.png',
                                  width: 48,
                                  height: 48,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Product7[2].title,
                                    ),
                                    Text(
                                      Product7[2].title2,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.keyboard_arrow_left),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          )),
        ),
      ),
    );
  }

  Future<dynamic> BottomSheet(BuildContext context, Size size,
      List<Product7> Product7, int numberindex, int number) {
    return showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (context) {
        return Container(
          width: size.width,
          height: size.height * 0.59,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              final data = Product7[numberindex];

              return Column(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/shop.png',
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(data.title),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data.title3),
                            Text(data.title4),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data.title5),
                            Text(int.parse('150000')
                                .withPriceLable
                                .toString()
                                .toPersianDigit()),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data.title6),
                            Text(data.title7.toPersianDigit()),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data.title8),
                            Text(data.title9),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                  SizedBox(
                    width: size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Personnel(),
                          ),
                        );
                      },
                      child: const Text(
                        'لیست پرسنل فروشگاه',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                            () => NewStore(
                                  active: true,
                                  number: number,
                                  product: Product7,
                                ),
                            arguments: data);
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => NewStore(
                        //       active: true,
                        //       number: number,
                        //     ),
                        //   ),
                        // );
                      },
                      child: const Text(
                        'تغییر اطلاعات فروشگاه',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
