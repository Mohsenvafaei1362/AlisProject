import 'package:local_notification_flutter_project/ui/screens/cart/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Festival extends StatefulWidget {
  const Festival({Key? key}) : super(key: key);

  @override
  State<Festival> createState() => _FestivalState();
}

class _FestivalState extends State<Festival> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: 'http://allix.ir/catalog',
          // initialUrl: 'http://iranjib.ir/',
        ),
      ),
    );
    // return Scaffold(
    //   // backgroundColor: Colors.amber,
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           Container(
    //             width: size.width,
    //             height: size.height * 0.06,
    //             padding: const EdgeInsets.fromLTRB(0, 5, 20, 5),
    //             // margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
    //             decoration: const BoxDecoration(
    //               color: Colors.white,
    //               border: Border(
    //                 bottom: BorderSide(
    //                   color: Colors.black12,
    //                   width: 1,
    //                 ),
    //               ),
    //             ),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.pop(context);
    //                   },
    //                   child: const Icon(CupertinoIcons.arrow_right),
    //                 ),
    //                 const SizedBox(
    //                   width: 20,
    //                 ),
    //                 const Text(
    //                   'جشنواره تخفیفات عالیس',
    //                   style: TextStyle(
    //                     color: Colors.pink,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 const Spacer(),
    //                 // Align(
    //                 //   alignment: Alignment.topCenter,
    //                 //   child: Badge(
    //                 //     badgeContent: Obx(
    //                 //       () => Text(
    //                 //         '${cartController.products.length}'
    //                 //             .toPersianDigit(),
    //                 //         style: TextStyle(
    //                 //           color: Colors.white,
    //                 //         ),
    //                 //       ),
    //                 //     ),
    //                 //   ),
    //                 // ),
    //                 InkWell(
    //                   onTap: () {
    //                     Get.to(
    //                       const Directionality(
    //                         textDirection: TextDirection.rtl,
    //                         child: CartScreen(),
    //                       ),
    //                     );
    //                   },
    //                   child: const Align(
    //                     child: Icon(CupertinoIcons.cart),
    //                   ),
    //                 ),
    //                 const SizedBox(width: 15)
    //               ],
    //             ),
    //           ),
    //           Container(
    //             width: size.width,
    //             padding:
    //                 const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
    //             margin: const EdgeInsets.symmetric(vertical: 10),
    //             decoration: const BoxDecoration(
    //               color: Colors.white,
    //               border: Border(
    //                 bottom: BorderSide(
    //                   color: Colors.black12,
    //                   width: 1,
    //                 ),
    //               ),
    //             ),
    //             // height: size.height,
    //             child: const Text(
    //               'نوشابه های گازدار عالیس',
    //               style: TextStyle(
    //                 color: Colors.black54,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ),
    //           Container(
    //             width: size.width,
    //             height: size.height * 0.06,
    //             decoration: const BoxDecoration(color: Colors.white),
    //             // child:
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
