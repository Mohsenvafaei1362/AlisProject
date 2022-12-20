import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/repo/new_ticket_repository.dart';
import 'package:local_notification_flutter_project/ui/models/citymodel/citymodel.dart';
import 'package:local_notification_flutter_project/ui/models/eparchymodel/eparchymodel.dart';
import 'package:local_notification_flutter_project/ui/screens/Support/ChatScreen.dart';
import 'package:local_notification_flutter_project/ui/screens/Support/bloc/new_ticket_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class NewTicket extends StatefulWidget {
  const NewTicket({
    Key? key,
  }) : super(key: key);

  @override
  State<NewTicket> createState() => _NewTicketState();
}

class _NewTicketState extends State<NewTicket> {
  final UiTimerUser timerUser = Get.put(UiTimerUser());
  final UiPhoneController getinfo = Get.put(UiPhoneController());
  final UiDl _dl = Get.put(UiDl());
  final picker1 = ImagePicker();
  File? _file1;

  String? _image1;
  Future getImage() async {
    final pickedFile = await picker1.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _file1 = File(pickedFile.path);
        List<int> bytes = utf8.encode(pickedFile.path);
        final imageEncoded = base64.encode(bytes);
        _image1 = imageEncoded;

        ///Check Size Image
        final _bytes = _file1!.readAsBytesSync().lengthInBytes;
        double m = ((_bytes / 1024.0) / 1024.0);
        if (m > 5) {
          // showDialog(
          //   context: context,
          //   builder: ((context) => Dialog(
          //       context: context,
          //       warning: '!!! توجه',
          //       title:
          //           'حجم عکس نباید بیشتر از 5 مگا بایت باشد'.toPersianDigit(),
          //       button: 'متوجه شدم')),
          // );
        }
      } else {
        print('No image selected.');
      }
    });
  }

  Future getgallery() async {
    final pickedFile = await picker1.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _file1 = File(pickedFile.path);
        //  var magebytes =  _file1!.readAsBytes();
        List<int> bytes = utf8.encode(pickedFile.path);
        final imageEncoded = base64.encode(bytes);
        _image1 = imageEncoded;

        ///Check Size Image
        final _bytes = _file1!.readAsBytesSync().lengthInBytes;
        double m = ((_bytes / 1024.0) / 1024.0);
        if (m > 5) {
          // showDialog(
          //   context: context,
          //   builder: ((context) => Dialog(
          //       context: context,
          //       warning: '!!! توجه',
          //       title:
          //           'حجم عکس نباید بیشتر از 5 مگا بایت باشد'.toPersianDigit(),
          //       button: 'متوجه شدم')),
          // );
        }
      } else {
        print('No image selected.');
      }
    });
  }

  // final UiFlag flag = Get.put(UiFlag());
  final List<String> items = [
    'مشکل در سفارش',
    'پرداخت ناموفق',
    'دریافت مشاوره',
    'درخواست تماس پشتیبانی با شما',
  ];
  String? selectedValue;
  final List<String> items2 = [
    'شماره سفارش 234684131810'.toPersianDigit(),
    'شماره سفارش 313468541242'.toPersianDigit(),
    'آخرین سفارش من',
    'سفارش من در این لیست نیست',
  ];
  String? selectedValue2;
  CityModel? _selected;
  List<Widget> data = [Text('')];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<NewTicketBloc>(
        create: (context) =>
            NewTicketBloc(newTicketRepository: newTicketRepository),
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<NewTicketBloc, NewTicketState>(
              builder: (context, state) {
                // if (state is NewTicketSuccess) {
                return HawkFabMenu(
                  icon: AnimatedIcons.menu_arrow,
                  fabColor: Colors.blue,
                  iconColor: Colors.white,
                  items: [
                    HawkFabMenuItem(
                      label: 'چت با پشتیبانی',
                      ontap: () {
                        Get.to(
                          const ChatScreen(),
                        );
                      },
                      icon: const Icon(Icons.comment),
                      labelColor: Colors.white,
                      labelBackgroundColor: Colors.blue,
                    ),
                  ],
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 15, 12, 12),
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'همه روزه',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          'ساعت 8 تا 22'.toPersianDigit(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              'مرکز تماس امور مشتریان',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.phone,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '0513187'.toPersianDigit(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        const Padding(
                          padding: EdgeInsets.all(32),
                          child: Text(
                            'برای پیگیری سفارش یا طرح سوالات خود، از طریق فرم زیر با ما در ارتباط باشید . تلاش میکنیم هرچه سریعتر به مشکل شما رسیدگی کنیم',
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownSearch<EparchyModel>(
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: 'موضوع درخواست را انتخاب فرمایید',
                                // hintText: "country in menu mode",
                              ),
                            ),
                            // dropdownSearchDecoration: InputDecoration(labelText: "Name"),

                            asyncItems: (String filter) async {
                              var response =
                                  await httpClient.get('Const/eparchy');
                              var models =
                                  EparchyModel.fromJsonList(response.data);
                              return models;
                            },

                            onChanged: (EparchyModel? eparchy) {
                              getinfo.ostan.value =
                                  eparchy!.EparchyTitle.toString();
                              getinfo.ostanid.value = eparchy.EparchyId;
                              _dl.Ostan.value = eparchy.EparchyTitle.toString();
                              // _selected =
                              //     CityModel(CityId: 0, CityName: cityInfo.city.value);
                              setState(() {
                                _selected = CityModel(
                                    CityId: 0,
                                    CityName: 'سفارش خود را انتخاب فرمایید');
                                data.clear();
                                data.add(DropdownSearch<CityModel>(
                                  dropdownDecoratorProps:
                                      const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      labelText: 'سفارش خود را انتخاب فرمایید',

                                      // hintText: "country in menu mode",
                                    ),
                                  ),
                                  // dropdownSearchDecoration: InputDecoration(labelText: "Name"),
                                  selectedItem: _selected,

                                  asyncItems: (String filter) async {
                                    var response = await httpClient.get(
                                        'Const/City/city',
                                        queryParameters: {
                                          "EparchyId": getinfo.ostanid.value
                                        });
                                    var models =
                                        CityModel.fromJsonList(response.data);
                                    return models;
                                  },

                                  onChanged: (CityModel? citymodel) {
                                    getinfo.city.value =
                                        citymodel!.CityName.toString();
                                    getinfo.cityid.value = citymodel.CityId;
                                    _dl.City.value =
                                        citymodel.CityName.toString();
                                  },
                                ));
                              });
                            },
                          ),
                        ),
                        data[0],
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child: TextField(
                            style: TextStyle(fontFamily: 'IransansDn'),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'توضیحات',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: _file1 == null
                                    ? Image.asset(
                                        'assets/images/upload.png',
                                        width: 68,
                                        height: 68,
                                      )
                                    : Image.file(
                                        _file1!,
                                        width: 100,
                                        height: 68,
                                      ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 40,
                                width: 70,
                                decoration: const BoxDecoration(
                                    // border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: Colors.green),
                                child: const Center(
                                  child: Text(
                                    'ارسال',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      // title: Center(
                                      //     child: const Text('اسکن مدارک')),
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              getgallery();
                                              Navigator.of(context).pop();
                                              // getmadrak();
                                            },
                                            child: Container(
                                              width: size.width * 0.2,
                                              height: size.height * 0.05,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'گالری',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              getImage();
                                              Navigator.of(context).pop();
                                              // getmadrak();
                                            },
                                            child: Container(
                                              width: size.width * 0.2,
                                              height: size.height * 0.05,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'دوربین',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('پیوست فایل'),
                                      Icon(
                                        Icons.upload,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                // } else if (state is NewTicketLoading) {
                //   return const Center(
                //     child: CupertinoActivityIndicator(),
                //   );
                // } else if (state is NewTicketError) {
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
    );
  }
}
