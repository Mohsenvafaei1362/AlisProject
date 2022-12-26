import 'dart:async';
import 'dart:convert';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/message_box_info.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Club_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Ghole_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/message_box_repository.dart';
import 'package:local_notification_flutter_project/ui/models/message_box/message_box_post/message_post1.dart';
import 'package:local_notification_flutter_project/ui/root.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/home.dart';
import 'package:local_notification_flutter_project/ui/screens/MessageBox/bloc/message_box_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({Key? key, this.message, this.isActive, this.payload})
      : super(key: key);

  final List<MessageCount>? message;
  final bool? isActive;
  final String? payload;

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final UiTimerUser timerUser = Get.put(UiTimerUser());
  // final UiFlag flag = Get.put(UiFlag());

  late final MessageCount? data;
  StreamSubscription? subscription;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // final product3 = AllProducts3.products3;
    final size = MediaQuery.of(context).size;
    print(widget.payload);
//decode base64 stirng to bytes
    // Uint8List decodedbytes = base64.decode(base64string);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<MessageBoxBloc>(
        create: (context) {
          final bloc = MessageBoxBloc(
            messageBoxRepository: messageBoxRepository,
            messageCountRepository: messageCountRepository,
            clubRepository: clubRepository,
            gholeRepository: gholeRepository,
          );
          bloc.add(MessageBoxStarted());
          subscription = bloc.stream.listen(
            (state) {
              // if (state is MessageBoxNextPage) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => Directionality(
              //         textDirection: TextDirection.rtl,
              //         child: Message_Post1(
              //           message: data!,
              //         ),
              //       ),
              //     ),
              //   );
              // }
            },
          );
          return bloc;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<MessageBoxBloc, MessageBoxState>(
              // buildWhen: (previous, current) {
              //   return current is MessageBoxError ||
              //       current is MessageBoxInitial ||
              //       current is MessageBoxLoading;
              // },
              builder: (context, state) {
                if (state is MessageBoxSuccess) {
                  // final successState = (state as MessageBoxSuccess);
                  // print(successState.messageCount[0].isActive);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: RootScreen())));
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                              ),
                            ),
                            const Text('صندوق پیام ها'),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '( پیغام خوانده نشده  ${state.messageCount.length})'
                                  .toPersianDigit(),
                              style: const TextStyle(fontSize: 8),
                            )
                          ],
                        ),
                      ),
                      widget.payload != null
                          ? Text(
                              widget.payload.toString(),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          : Text(''),
                      SizedBox(
                        width: size.width,
                        height: size.height,
                        child: ListView.builder(
                          itemCount: state.messageCount.length,
                          itemBuilder: (context, index) {
                            data = state.messageCount[index];
                            var avatar = base64.decode(data!.Avatar.toString());
                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: InkWell(
                                onTap: () {
                                  // print(index);
                                  // setState(() {
                                  //   isActive = false;
                                  // });

                                  // setState(() {
                                  //   successState.messageCount[0].isActive =
                                  //       false;
                                  // });

                                  BlocProvider.of<MessageBoxBloc>(context).add(
                                    MessageBoxClicked(data!.ID),
                                  );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => Directionality(
                                  //       textDirection: TextDirection.rtl,
                                  //       child: Message_Post1(
                                  //         message: data,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: Row(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.memory(
                                            avatar,
                                            width: 68,
                                            height: 68,
                                          ),
                                        ),
                                        // successState
                                        //         .messageCount[index].isActive
                                        state.messageCount[index].IsRead
                                            ? Positioned(
                                                top: -2,
                                                right: -2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.green[300],
                                                  ),
                                                  width: 10,
                                                  height: 10,
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data!.Title,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          data!.Desc,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black45),
                                        ),
                                        Text(
                                          data!.PersianDate,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is MessageBoxLoading) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else if (state is MessageBoxError) {
                  return Center(
                    child: Text(state.exception.message),
                  );
                } else if (state is MessageBoxNextPage) {
                  return Container();
                } else {
                  print(state);
                  throw Exception('state is not supported');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
