import 'package:local_notification_flutter_project/ui/data/repo/partners_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/Partners/bloc/partners_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/Setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Partners extends StatefulWidget {
  const Partners({Key? key}) : super(key: key);

  @override
  State<Partners> createState() => _PartnersState();
}

class _PartnersState extends State<Partners> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<PartnersBloc>(
        create: (context) {
          final bloc = PartnersBloc(partnersRepository: partnersRepository);
          bloc.add(PartnersStarted());
          return bloc;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<PartnersBloc, PartnersState>(
              builder: (context, state) {
                if (state is PartnersSuccess) {
                  //
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Settings(),
                                  ),
                                ),
                              );
                            },
                            child: const Icon(Icons.keyboard_arrow_right),
                          ),
                          const Text('همکاران من'),
                          const Icon(Icons.question_mark_rounded),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'همکارانی که توسط شما معرفی شدند:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // if (state is PartnersSuccess)
                    // state.partners.first.name;
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/user.png',
                              width: 48,
                              height: 48,
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('فروشگاه وفایی'),
                                Text(
                                  'آنلاین',
                                  style: TextStyle(color: Colors.blue[200]),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              width: 90,
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Center(
                                  child: Text(
                                'دریافت پاداش',
                                style: TextStyle(color: Colors.green),
                              )),
                            ),
                          ]),
                    ),
                    // if (state is PartnersLoading)
                    //   const Center(
                    //     child: CupertinoActivityIndicator(),
                    //   ),
                    // if (state is PartnersError)
                    //   Center(
                    //     child: Text(state.exception.message),
                    //   ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
