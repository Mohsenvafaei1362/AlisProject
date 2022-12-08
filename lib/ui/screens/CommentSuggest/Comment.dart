import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late int selectedValue1;
  late int selectedValue2;
  late int selectedValue3;
  late int selectedValue4;
  late int selectedValue5;
  late int selectedValue6;
  late int selectedValue7;
  void onChange1(int value) {
    setState(() {
      selectedValue1 = value;
    });
  }

  void onChange2(int value) {
    setState(() {
      selectedValue2 = value;
    });
  }

  void onChange3(int value) {
    setState(() {
      selectedValue3 = value;
    });
  }

  void onChange4(int value) {
    setState(() {
      selectedValue4 = value;
    });
  }

  void onChange5(int value) {
    setState(() {
      selectedValue5 = value;
    });
  }

  void onChange6(int value) {
    setState(() {
      selectedValue6 = value;
    });
  }

  void onChange7(int value) {
    setState(() {
      selectedValue7 = value;
    });
  }

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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.06,
                  padding: const EdgeInsets.fromLTRB(0, 5, 20, 5),
                  // margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                        width: 1,
                      ),
                    ),
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
                        'فرم نظر سنجی',
                        style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      DefaultTabController(
                        length: 2, // length of tabs
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: const TabBar(
                                labelColor: Colors.green,
                                unselectedLabelColor: Colors.black,
                                tabs: [
                                  Tab(text: 'شرکت در نظر سنجی'),
                                  Tab(text: 'لیست نظر سنجی ها'),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width,
                              height: size.height * 1.5, //height of TabBarView
                              decoration: const BoxDecoration(
                                // color: Colors.amber,
                                border: Border(
                                  top: BorderSide(
                                      color: Colors.grey, width: 0.5),
                                ),
                              ),
                              child: TabBarView(
                                children: <Widget>[
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 50, 8, 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                'https://www.google.com',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 50, 8, 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                'https://www.google.com',
                                              ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
