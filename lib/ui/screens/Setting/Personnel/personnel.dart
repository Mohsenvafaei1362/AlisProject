import 'package:local_notification_flutter_project/ui/data/repo/personnel_repository.dart';
import 'package:local_notification_flutter_project/ui/models/data_settings_store.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/Personnel/bloc/personnel_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Personnel extends StatefulWidget {
  @override
  State<Personnel> createState() => _PersonnelState();
}

class _PersonnelState extends State<Personnel> {
  // const Personnel({Key? key}) : super(key: key);
  final Product7 = AllPersonnelShop.personnelShop;

  final List<String> items = [
    'فروشگاه طالقانی',
    'فروشگاه عبادی',
    'فروشگاه طبرسی',
  ];

  String? nameStore;
  PersonnelBloc? personnelBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    personnelBloc?.close();
  }

  final TextEditingController fname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController nationalcode = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController namestore = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    title: const Text('اضافه کردن پرسنل جدید'),
                    actions: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          controller: fname,
                          style: const TextStyle(
                              fontFamily: 'IransansDn',
                              fontSize: 10,
                              color: Colors.blue),
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            labelText: 'نام ',

                            //
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          controller: lname,
                          style: const TextStyle(
                              fontFamily: 'IransansDn',
                              fontSize: 10,
                              color: Colors.blue),
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            labelText: 'نام خانوادگی',

                            //
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          controller: nationalcode,
                          style: const TextStyle(
                              fontFamily: 'IransansDn',
                              fontSize: 10,
                              color: Colors.blue),
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            labelText: 'کد ملی',

                            //
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          controller: phone,
                          style: const TextStyle(
                              fontFamily: 'IransansDn',
                              fontSize: 10,
                              color: Colors.blue),
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            labelText: 'شماره تماس',

                            //
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          controller: namestore,
                          style: const TextStyle(
                              fontFamily: 'IransansDn',
                              fontSize: 10,
                              color: Colors.blue),
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            labelText: 'نام فروشگاه',

                            //
                          ),
                        ),
                      ),
                      // DropdownButtonHideUnderline(
                      //   child: DropdownButton2(
                      //     hint: Text(
                      //       'انتخاب فروشگاه',
                      //       style: TextStyle(
                      //         fontSize: 14,
                      //         color: Theme.of(context).hintColor,
                      //         fontFamily: 'IransansDn',
                      //       ),
                      //     ),
                      //     items: items
                      //         .map((item) => DropdownMenuItem<String>(
                      //               value: item,
                      //               child: Text(
                      //                 item,
                      //                 style: const TextStyle(
                      //                   fontSize: 14,
                      //                 ),
                      //               ),
                      //             ))
                      //         .toList(),
                      //     value: nameStore,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         nameStore = value as String;
                      //       });
                      //     },
                      //     buttonHeight: 40,
                      //     buttonWidth: 140,
                      //     itemHeight: 40,
                      //   ),
                      // ),

                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          personnelBloc?.add(
                            PersonnelClickedButton(
                              fname: fname.text,
                              lname: lname.text,
                              namestore: namestore.text,
                              nationalcode: int.parse(nationalcode.text),
                              phonenumber: int.parse(phone.text),
                            ),
                          );
                        },
                        child: const Text(
                          'ذخیره اطلاعات',
                          style: TextStyle(fontFamily: 'IransansDn'),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider<PersonnelBloc>(
        create: (context) {
          final bloc = PersonnelBloc(personnelRepository: personnelRepository);
          personnelBloc = bloc;
          bloc.add(PersonnelStarted());
          return bloc;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<PersonnelBloc, PersonnelState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.keyboard_arrow_right),
                          ),
                          const Text('پرسنل فروشگاه'),
                          const Icon(Icons.question_mark_rounded),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'توجه: ',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  child: Text(
                                    'افرادی که در این لیست اضافه می شوند می توانند  کالای خریداری شده توسط شما را تحویل گیرند.',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black45,
                                      height: 1.8,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 16, 0),
                            child: Text('لیست پرسنل فروشگاه'),
                          ),
                        ],
                      ),
                    ),
                    if (state is PersonnelSuccessgetPersonnel)
                      SizedBox(
                        width: size.width,
                        height: size.height,
                        child: ListView.builder(
                          itemCount: Product7.length,
                          itemBuilder: (context, index) {
                            final data = Product7[index];

                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: InkWell(
                                onTap: () {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.INFO,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: data.title,
                                    desc: data.title2,
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                    btnOkText: 'ویرایش',
                                    buttonsTextStyle: const TextStyle(
                                        fontFamily: 'IransansDn'),
                                    btnCancelText: 'حذف',
                                    customHeader:
                                        Image.asset('assets/icons/user.png'),
                                  ).show();
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        data.image,
                                        width: 48,
                                        height: 48,
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data.title),
                                          Text(
                                            data.title2,
                                            style: TextStyle(
                                                color: Colors.blue[200]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    if (state is PersonnelLoading)
                      const Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    if (state is PersonnelErrorgetPersonnel)
                      Center(
                        child: Text(state.exception.message),
                      ),
                    if (state is PersonnelSuccessSendPersonnel)
                      if (state is PersonnelErrorSendPersonnel)
                        const SnackBar(content: Text('خطا در ارسال اطلاعات'))
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
