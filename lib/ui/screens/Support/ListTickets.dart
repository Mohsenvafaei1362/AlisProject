import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/list_ticket_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Support/bloc/list_tickets_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ListTickets extends StatefulWidget {
  const ListTickets({
    Key? key,
  }) : super(key: key);

  @override
  State<ListTickets> createState() => _ListTicketsState();
}

class _ListTicketsState extends State<ListTickets> {
  // final UiTimerUser timerUser = Get.put(UiTimerUser());
  // final UiFlag flag = Get.put(UiFlag());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<ListTicketsBloc>(
        create: (context) {
          final bloc =
              ListTicketsBloc(listTicketRepository: listTicketRepository);
          bloc.add(ListTicketsStarted());
          return bloc;
        },
        child: SafeArea(
          child: BlocBuilder<ListTicketsBloc, ListTicketsState>(
            builder: (context, state) {
              // if (state is ListTicketsSuccess) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: InkWell(
                      onTap: () {
                        // Get.to(
                        //   const Directionality(
                        //     textDirection: TextDirection.rtl,
                        //     child: Ticket(),
                        //   ),
                        // );
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/support.png',
                            width: 48,
                            height: 48,
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Text('موضوع : '),
                                  Text('ثبت سفارش'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'پشتیبان : ',
                                    style: TextStyle(
                                        color: Colors.blue[200], fontSize: 10),
                                  ),
                                  Text(
                                    'علی احمدی',
                                    style: TextStyle(
                                        color: Colors.blue[200], fontSize: 10),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'تاریخ ثبت تیکت: ',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black45),
                                  ),
                                  Text(
                                    '1401/05/05'.toPersianDigit(),
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.black45),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.keyboard_arrow_left),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      width: size.width * 0.9,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.red.shade400,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const Directionality(
                            //       textDirection: TextDirection.rtl,
                            //       child: Repeate(),
                            //     ),
                            //   ),
                            // );
                          },
                          child: const Text(
                            'سوالات پرتکرار',
                            style: TextStyle(
                              fontFamily: 'IransansDn',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
              // } else if (state is ListTicketsLoading) {
              //   return const Center(
              //     child: CupertinoActivityIndicator(),
              //   );
              // } else if (state is ListTicketsError) {
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
