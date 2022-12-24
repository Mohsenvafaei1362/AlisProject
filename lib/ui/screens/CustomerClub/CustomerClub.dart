import 'dart:async';

import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/customer_club_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/topPepole_repository.dart';
import 'package:local_notification_flutter_project/ui/models/Pepole/pepole.dart';
import 'package:local_notification_flutter_project/ui/models/data_message_box.dart';
import 'package:local_notification_flutter_project/ui/screens/CustomerClub/LuckWheel.dart';
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

  final pepole = AllPepole3.pepoles3;
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
                            color: Colors.lightBlueAccent[700],
                            borderRadius: BorderRadius.circular(20),
                            // image: const DecorationImage(
                            //   fit: BoxFit.cover,
                            //   image: AssetImage(
                            //     'assets/images/7773.jpg',
                            //   ),
                            // ),
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
                                    final data = pepole[index];
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
                                          Icon(
                                            Icons.person,
                                            color: Colors.black38,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.27,
                                            child: Text(
                                              '${data.name}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                            child: Text(
                                              '${data.rank}'.toPersianDigit(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${data.score}'.toPersianDigit(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'امتیاز',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      _club.score.toString().toPersianDigit(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  'assets/images/target.png',
                                  height: 70,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      height: 15,
                                    ),
                                    Text(
                                      _dl.Role.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
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
                      ButtonBox(
                        size: size,
                        title1: 'وام های قرض الحسنه',
                        backgroundcolor1: Colors.white,
                        textcolor1: Colors.blue,
                        bordercolor1: Colors.blue,
                        press1: () {},
                        title2: 'بسته های اعتباری',
                        backgroundcolor2: Colors.white,
                        textcolor2: Colors.red,
                        bordercolor2: Colors.red,
                        press2: () {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ButtonBox(
                        size: size,
                        title1: 'آموزش',
                        backgroundcolor1: Colors.white,
                        textcolor1: Colors.orange,
                        bordercolor1: Colors.orange,
                        press1: () {},
                        title2: 'مسابقات',
                        backgroundcolor2: Colors.white,
                        textcolor2: Colors.green,
                        bordercolor2: Colors.green,
                        press2: () {},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ButtonBox(
                        size: size,
                        title1: 'گردونه شانس',
                        backgroundcolor1: Colors.white,
                        textcolor1: Colors.cyan,
                        bordercolor1: Colors.cyan,
                        press1: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Directionality(
                                textDirection: TextDirection.rtl,
                                child: LuckWheel(),
                              ),
                            ),
                          );
                        },
                        title2: 'مسیر پیشرفت',
                        backgroundcolor2: Colors.white,
                        textcolor2: Colors.amber,
                        bordercolor2: Colors.amber,
                        press2: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Directionality(
                                textDirection: TextDirection.rtl,
                                child: Introducing_Ghole(),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.05,
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
                      SizedBox(
                        height: size.height * 0.03,
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

class ButtonBox extends StatelessWidget {
  const ButtonBox({
    Key? key,
    required this.size,
    required this.title1,
    required this.title2,
    required this.backgroundcolor1,
    required this.backgroundcolor2,
    required this.textcolor1,
    required this.textcolor2,
    required this.bordercolor1,
    required this.bordercolor2,
    required this.press1,
    required this.press2,
  }) : super(key: key);

  final Size size;
  final String title1, title2;
  final Color backgroundcolor1, backgroundcolor2;
  final Color textcolor1, textcolor2;
  final Color bordercolor1, bordercolor2;
  final GestureTapCallback press1, press2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonItem(
              size: size,
              backgroundcolor: backgroundcolor1,
              textcolor: textcolor1,
              bordercolor: bordercolor1,
              press: press1,
              title: title1),
          ButtonItem(
              size: size,
              backgroundcolor: backgroundcolor2,
              textcolor: textcolor2,
              bordercolor: bordercolor2,
              press: press2,
              title: title2)
        ],
      ),
    );
  }
}

class ButtonItem extends StatelessWidget {
  const ButtonItem({
    Key? key,
    required this.size,
    required this.backgroundcolor,
    required this.textcolor,
    required this.bordercolor,
    required this.press,
    required this.title,
  }) : super(key: key);

  final Size size;
  final Color backgroundcolor;
  final Color textcolor;
  final Color bordercolor;
  final GestureTapCallback press;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.4,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundcolor,
          foregroundColor: textcolor,
          side: BorderSide(width: 1, color: bordercolor),
        ),
        onPressed: press,
        child: Text(title),
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
