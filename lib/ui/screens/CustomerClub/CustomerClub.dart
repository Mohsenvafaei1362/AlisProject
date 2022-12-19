import 'dart:async';

import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/customer_club_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/topPepole_repository.dart';
import 'package:local_notification_flutter_project/ui/models/Pepole/pepole.dart';
import 'package:local_notification_flutter_project/ui/screens/CustomerClub/bloc/customer_club_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/Ghole/introducing_ghole.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CustomerClub extends StatefulWidget {
  CustomerClub({Key? key}) : super(key: key);

  @override
  State<CustomerClub> createState() => _CustomerClubState();
}

class _CustomerClubState extends State<CustomerClub> {
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // streamSubscription?.cancel();
  }

  final UiDl _dl = Get.put(UiDl());
  final Club _club = Get.put(Club());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // const rankPepole = Pepole.pepoles;

    return SafeArea(
      child: Scaffold(
        body: BlocProvider<CustomerClubBloc>(
          create: (context) {
            final bloc = CustomerClubBloc(
              customerClubRepository: customerClubRepository,
              topPepoleRepository: topPepoleRepository,
            );
            bloc.add(CustomerClubStarted());
            // streamSubscription = bloc.stream.listen(
            //   (state) {},
            // );

            return bloc;
          },
          child: SingleChildScrollView(
            child: SafeArea(
              child: BlocBuilder<CustomerClubBloc, CustomerClubState>(
                builder: (context, state) {
                  // if (state is CustomerClubSuccess) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 32, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: HomeScreen_Ui(),
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.keyboard_arrow_right)),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text(
                              'باشگاه مشتریان',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ClipOval(
                              child: Image.memory(
                                _club.image,
                                width: 50,
                                height: 50,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              ' ${_dl.FName} ${_dl.LName}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            // RichText(
                            //   text: TextSpan(
                            //       text: _club.score.toString().toPersianDigit(),
                            //       style: const TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black54,
                            //         fontSize: 16,
                            //       ),
                            //       children: const [
                            //         TextSpan(
                            //           text: ' تومان',
                            //           style: TextStyle(
                            //             fontWeight: FontWeight.normal,
                            //             fontSize: 10,
                            //             color: Colors.black54,
                            //           ),
                            //         ),
                            //       ]),
                            // ),
                            // const SizedBox(
                            //   width: 15,
                            // ),
                            // const Text('امتیاز'),
                            // const SizedBox(
                            //   width: 5,
                            // ),
                            // Text(
                            //   _club.score.toString().toPersianDigit(),
                            //   style: const TextStyle(color: Colors.green),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'رتبه ها',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                        child: Container(
                          height: size.height / 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/7773.jpg',
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.1,
                                      child: const Text(
                                        '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'نام کاربری',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    const Text(
                                      'رتبه',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    const Text(
                                      'امتیاز',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                width: size.width * 0.7,
                                height: size.height / 8,
                                child: ListView.builder(
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    // final data = state.topPepole[index];
                                    return Container(
                                      width: size.width,
                                      height: size.height * 0.037,
                                      margin: const EdgeInsets.all(2),
                                      // color: Colors.amber,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          // ClipOval(
                                          //   child: Image.asset(
                                          //     data.image,
                                          //     width: 30,
                                          //   ),
                                          // ),
                                          // SizedBox(
                                          //   width: size.width * 0.27,
                                          //   child: Text(
                                          //     data.name,
                                          //     style: const TextStyle(
                                          //         color: Colors.white),
                                          //   ),
                                          // ),
                                          // SizedBox(
                                          //   width: size.width * 0.1,
                                          //   child: Text(
                                          //     '${data.rank}',
                                          //     style: const TextStyle(
                                          //         color: Colors.white),
                                          //   ),
                                          // ),
                                          // Text(
                                          //   '${data.score}',
                                          //   style: const TextStyle(
                                          //       color: Colors.white),
                                          // ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // Ranking(),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 12, 32, 0),
                        child: Container(
                          height: 125,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/777.png',
                              ),
                            ),
                            // color: Colors.red,
                            // backgroundBlendMode: Image.asset('name'),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'امتیاز',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      _club.score.toString().toPersianDigit(),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  'assets/images/target.png',
                                  height: 70,
                                ),
                                Column(
                                  children: [
                                    ClipOval(
                                      child: Image.memory(
                                        _club.imageLevel,
                                        width: 30,
                                      ),
                                    ),
                                    // Image.asset(
                                    //   'assets/images/medal.png',
                                    //   height: 45,
                                    // ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      _dl.Role.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('قله:',
                                    style: TextStyle(color: Colors.black45)),
                                Text(
                                  'سهند - سطح 5'.toPersianDigit(),
                                  style: const TextStyle(color: Colors.black45),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('مجموع ریال:',
                                    style: TextStyle(color: Colors.black45)),
                                Text('33,494'.toPersianDigit(),
                                    style:
                                        const TextStyle(color: Colors.black45)),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('مجموع ریال کسب شده امروز:',
                                    style: TextStyle(color: Colors.black45)),
                                Text('0'.toPersianDigit(),
                                    style:
                                        const TextStyle(color: Colors.black45)),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('مجموع امتیاز:',
                                    style: TextStyle(color: Colors.black45)),
                                Text(_club.score.toString().toPersianDigit(),
                                    style:
                                        const TextStyle(color: Colors.black45)),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('مجموع امتیاز کسب شده امروز:',
                                    style: TextStyle(color: Colors.black45)),
                                Text('0'.toPersianDigit(),
                                    style:
                                        const TextStyle(color: Colors.black45)),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width / 2.5,
                              height: size.height * 0.05,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'وام های قرض الحسنه',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width / 2.5,
                              height: size.height * 0.05,
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'بسته های اعتباری',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                // Get.to(
                                //   Directionality(
                                //     textDirection: TextDirection.rtl,
                                //     child: Introducing_Club(),
                                //   ),
                                // );
                              },
                              child: Container(
                                width: size.width / 2.5,
                                height: size.height * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    'آموزش',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width / 2.5,
                              height: size.height * 0.05,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'مسابقات',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
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
                                            child: Introducing_Ghole(),
                                          )),
                                );
                              },
                              child: Container(
                                width: size.width * 0.8,
                                height: size.height * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.cyan,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    'مسیر پیشرفت',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      SizedBox(
                        width: size.width * 0.9,
                        height: size.height * 0.06,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'تبدیل امتیاز به وجه',
                            style: TextStyle(fontFamily: 'IransansDn'),
                          ),
                        ),
                      ),
                    ],
                  );
                  // } else if (state is CustomerClubLoading) {
                  //   return const Center(
                  //     child: CupertinoActivityIndicator(),
                  //   );
                  // } else if (state is CustomerClubError) {
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
        ),
      ),
    );
  }
}

class Ranking extends StatelessWidget {
  const Ranking({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const rankPepole = Pepole.pepoles;
    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          final data = rankPepole[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Image.asset('assets/stories/${data.image}'),
              Text(
                data.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
            ],
          );
        },
      ),
      // RowRanking(name: name, image: image, rank: rank, score: score),
    );
  }
}

class RowRanking extends StatelessWidget {
  const RowRanking({
    Key? key,
    required this.name,
    required this.image,
    required this.rank,
    required this.score,
  }) : super(key: key);
  final String name, image;
  final int rank, score;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/stories/$image'),
        Text(
          name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
        ),
        Text(
          '$score',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
        ),
        Text(
          '$rank',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
        ),
      ],
    );
  }
}
