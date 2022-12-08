import 'dart:convert';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/home.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_utils/persian_utils.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:http/http.dart' as http;

class Serching2 extends StatefulWidget {
  const Serching2({Key? key}) : super(key: key);

  @override
  State<Serching2> createState() => _Serching2State();
}

final UiAddressIp getAddress2 = Get.put(UiAddressIp());
final UiCounter counter = Get.put(UiCounter());

class _Serching2State extends State<Serching2> {
  UiSearching searching = Get.put(UiSearching());
  final UiCartController cartController = Get.put(UiCartController());
  final UiTimerUser timerUser = Get.put(UiTimerUser());
  // final UiFlag flag = Get.put(UiFlag());
  var myurl = getAddress2.Get_url('products');
  var x = 0;
  var userMap = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcategory();
  }

  Map? infomap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool showfab = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        // width: size.width * 0.9,
        // height: size.height * 0.06,
        visible: !showfab,
        child: FloatingActionButton.extended(
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
          backgroundColor: Colors.transparent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen_Ui(),
              ),
            );
          },
          label: Center(
            child: Container(
              width: size.width * 0.9,
              height: size.height * 0.06,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: const Color(0xffef5350),
                  borderRadius: BorderRadius.circular(5)),
              child: const Center(
                child: Text('ادامه خرید'),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xffeceff1),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                border: Border.all(
                  color: Colors.black26,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.keyboard_backspace_rounded)),
                  Container(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    width: size.width * 0.87,
                    height: size.height * 0.06,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      // color: Colors.amber,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'هلدینگ عالیس',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Badge(
                            badgeContent: Obx(
                              () => Text(
                                '${cartController.products.length}'
                                    .toPersianDigit(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Get.to(
                            //   Directionality(
                            //     textDirection: TextDirection.rtl,
                            //     child: CartNew(),
                            //   ),
                            // );
                          },
                          child: const Align(
                            child: Icon(CupertinoIcons.cart),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              height: size.height * 0.68,
              // color: Colors.amber,
              child: ListView.builder(
                // padding: EdgeInsets.zero,
                itemCount: userMap.length,
                itemBuilder: (contex, index) {
                  infomap = userMap[index];

                  // final data = userMap[index]['categories'];
                  // final data2 = userMap[index]['name'];
                  // final data3 = userMap[index]['image'];
                  // final data4 = userMap[index]['Price'];
                  // final data5 = userMap[index]['Score'];
                  // final data6 = userMap[index]['category'];
                  // final data7 = userMap[index]['mojodi_addad'];
                  // final data8 = userMap[index]['darsad'];

                  //  return Center(child: Text('${data}'));

                  if (searching.valuefirst.value == 'true' &&
                      userMap[index]['product_category'] == 'شیر') {
                    return namayesh(size, infomap);
                    // return namayesh(size, data3, data2, data5, data4);
                  }
                  if (searching.valuesecound.value == 'true' &&
                      userMap[index]['product_category'] == 'دوغ') {
                    return namayesh(size, infomap);
                  }
                  if (searching.valuetree.value == 'true' &&
                      userMap[index]['product_category'] == 'آبمیوه') {
                    return namayesh(size, infomap);
                  }
                  if (searching.valuefour.value == 'true' &&
                      userMap[index]['product_subcategory'] ==
                          'آبمیوه گازدار تشریفاتی') {
                    return namayesh(size, infomap);
                  }
                  if (searching.valuefive.value == 'true' &&
                      userMap[index]['product_subcategory'] ==
                          'آبمیوه گازدار تشریفاتی') {
                    return namayesh(size, infomap);
                  }
                  if (searching.valuesex.value == 'true' &&
                      userMap[index]['product_subcategory'] == 'شیر ساده') {
                    return namayesh(size, infomap);
                  }
                  if (searching.valueseven.value == 'true' &&
                      userMap[index]['product_subcategory'] == 'شیر طعم دار') {
                    return namayesh(size, infomap);
                  }
                  if (searching.valueeight.value == 'true' &&
                      userMap[index]['product_category'] == 'آب معدنی') {
                    return namayesh(size, infomap);
                  }
                  if (searching.valuenine.value == 'true' &&
                      userMap[index]['product_subcategory'] == 'ماءالشعیر') {
                    return namayesh(size, infomap);
                  }
                  if (searching.valueT.value == 'true' &&
                      userMap[index]['product_category'] == 'نوشابه') {
                    return namayesh(size, infomap);
                  }
                  if (searching.isSwitched.value == 'true' &&
                      userMap[index]['mojodi_addad'] >= 1) {
                    return namayesh(size, infomap);
                  }
                  if (searching.isSwitched_1.value == 'true' &&
                      userMap[index]['darsad'] >= 1) {
                    return namayesh(size, infomap);
                  }
                  return const Text('');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container namayesh(Size size, info) {
    // x += 1;
    // counter.counter.value = x;
    // print('x : ${x}');
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 2, 15, 2),
      width: size.width,
      height: size.height * 0.16,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            // color: Colors.yellow,
            color: Colors.white70,
          ),
        ],
        border: Border(
          bottom: BorderSide(
            //                   <--- left side
            color: Colors.black26,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                imageUrl: info['image_product'],
              ),
              // Image.network(
              //   '${data3}',
              //   width: size.width * 0.2,
              //   height: size.height,
              //   // fit: BoxFit.fill,
              // ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  info['product_name'].toString(),
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      info['product_score'].toString().toPersianDigit(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 15,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        // cartController.addToCArt(product);
                        // controller.increment();
                        // Get.to(
                        //   CartNew(),
                        // );
                        // print(info);
                        cartController.AddProduct(info);
                      },
                      child: const Icon(
                        CupertinoIcons.cart_badge_plus,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${info['product_price']}'
                          .seRagham()
                          .toString()
                          .toPersianDigit(),
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "ریال".toPersianNumbers(),
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getcategory() async {
    final response = await http.get(Uri.parse(myurl));
    final jsonData = jsonDecode(response.body) as List;
    setState(() {
      userMap = jsonData;
    });
  }
}
