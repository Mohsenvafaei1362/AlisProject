import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Test1 extends StatefulWidget {
  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;
  final RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Add To Cart'),
        ),
        body: SmartRefresher(
            controller: _refreshController,
            header: const ClassicHeader(
              completeText: 'با موفقیت انجام شد',
              refreshingText: 'در حال به روز رسانی',
              idleText: 'برای به روز رسانی پایین بکشید',
              releaseText: 'رها کنید',
              failedText: 'خطای نا مشخص',
              spacing: 2,
              completeIcon: Icon(
                CupertinoIcons.check_mark_circled,
                color: Colors.grey,
                size: 20,
              ),
            ),
            onRefresh: () {},
            child: Text('data')),
      ),
    );
  }
}
