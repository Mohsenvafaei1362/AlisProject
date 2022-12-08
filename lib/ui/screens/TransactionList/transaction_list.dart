import 'package:local_notification_flutter_project/ui/data/repo/transaction_list_repository.dart';
import 'package:local_notification_flutter_project/ui/models/Operation/operation.dart';
import 'package:local_notification_flutter_project/ui/screens/TransactionList/bloc/transaction_list_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/TransactionList/transaction_list_detailes.dart';
import 'package:local_notification_flutter_project/ui/screens/TransactionList/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  void initState() {
    super.initState();
    //startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<TransactionListBloc>(
        create: (context) {
          final bloc = TransactionListBloc(
              transactionListRepository: transactionListRepository);
          bloc.add(TransactionListStarted());
          return bloc;
        },
        child: SafeArea(
          child: BlocBuilder<TransactionListBloc, TransactionListState>(
            builder: (context, state) {
              // if (state is TransactionListSuccess) {
              // } else if (state is TransactionListLoading) {
              //   return const Center(
              //     child: CupertinoActivityIndicator(),
              //   );
              // } else if (state is TransactionListError) {
              //   return Center(
              //     child: Text(state.exception.message),
              //   );
              // } else {
              //   throw Exception('state is not supported');
              // }
              return SlidingUpPanel(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                minHeight: 450,
                maxHeight: size.height * 0.76,
                panel: Column(
                  children: [
                    const Icon(Icons.drag_handle_rounded),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      width: size.width,
                      height: size.height * 0.72,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: ListView.builder(
                        physics: const ScrollPhysics(),
                        itemCount: Operation_Api.operations.length,
                        itemBuilder: (context, index) {
                          final data = Operation_Api.operations[index];
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: TransactionListDetailes(
                                                  operation: Operation_Api
                                                      .operations[index]),
                                            )),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.fromLTRB(10, 50, 30, 20),
                                        width: size.width * 0.12,
                                        height: size.height * 0.052,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Center(
                                          child: data.icon,
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.05,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data.title),
                                          Text(
                                            'سه شنبه ، 28 تیر 1401 ، 18:30'
                                                .toPersianDigit(),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: data.color,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${data.price}'.toPersianDigit(),
                                            style: TextStyle(
                                              color: data.color == Colors.green
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Container(
                      width: size.width,
                      // height: size.height * 0.06,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      // margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      decoration: const BoxDecoration(
                        color: Colors.lightBlueAccent,
                        // border: Border(
                        //   bottom: BorderSide(
                        //     color: Colors.lightBlueAccent,
                        //     width: 1,
                        //   ),
                        // ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              CupertinoIcons.arrow_right,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'لیست تراکنش ها',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Align(
                              child: Icon(
                                CupertinoIcons.question_circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 40),
                      decoration: const BoxDecoration(
                        color: Colors.lightBlueAccent,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: const [
                                  // Text(
                                  //   state.transaction[0].inventory
                                  //       .toString()
                                  //       .toPersianDigit(),
                                  //   style: const TextStyle(
                                  //     color: Colors.white,
                                  //     fontWeight: FontWeight.bold,
                                  //     fontSize: 22,
                                  //   ),
                                  // ),
                                  Text(
                                    'موجودی حساب',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: const [
                                  // Text(
                                  //   state.transaction[0].validity
                                  //       .toString()
                                  //       .toPersianDigit(),
                                  //   style: const TextStyle(
                                  //     color: Colors.white,
                                  //     fontWeight: FontWeight.bold,
                                  //     fontSize: 22,
                                  //   ),
                                  // ),
                                  Text(
                                    'اعتبار',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Wallet()),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: size.width * 0.7,
                                  height: size.height * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        CupertinoIcons.add,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      const Text(
                                        'افزایش موجودی',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
