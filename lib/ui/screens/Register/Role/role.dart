// import 'package:local_notification_flutter_project/screens/settings/settings.dart';
import 'dart:async';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/repo/role_repository.dart';
import 'package:local_notification_flutter_project/ui/models/DL/editDl.dart';
import 'package:local_notification_flutter_project/ui/models/Dto/EditDlDto.dart';
import 'package:local_notification_flutter_project/ui/models/Dto/UserUpdateDto.dart';
import 'package:local_notification_flutter_project/ui/models/citymodel/citymodel.dart';
import 'package:local_notification_flutter_project/ui/models/eparchymodel/eparchymodel.dart';
import 'package:local_notification_flutter_project/ui/models/register/putregistermemberlevel.dart';
import 'package:local_notification_flutter_project/ui/models/textformfield/textformfield.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Role/bloc/role_screen_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class Role extends StatefulWidget {
  const Role({Key? key}) : super(key: key);

  @override
  State<Role> createState() => _RoleState();
}

final UiAddressIp getAddress2 = Get.put(UiAddressIp());
final UiPhoneController getinfo = Get.put(UiPhoneController());
final UiDl _dl = Get.put(UiDl());

class _RoleState extends State<Role> {
  String? gender;
  String? ui_gender;
  int? id;
  RoleScreenBloc? roleBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    roleBloc?.close();
    streamSubscription?.cancel();
  }

  CityModel? _selected;
  List<Widget> data = [Text('')];
  int state = 0;
  bool isClickedButton = false;
  bool isActive = false;
  bool stateSuccess = false;
  StreamSubscription? streamSubscription;

  final TextEditingController controlfname = TextEditingController();
  final TextEditingController controllname = TextEditingController();
  final TextEditingController controlemail = TextEditingController();
  final TextEditingController controlcode = TextEditingController();
  final TextEditingController controlcodeposti = TextEditingController();

  getUserInfo() {
    RolScreenGetInfoUser(
      controlfname.text,
      controllname.text,
      controlemail.text,
      int.parse(controlcode.text),
      getinfo.ostanid.value,
      getinfo.cityid.value,
      int.parse(controlcodeposti.text),
      getinfo.city.value,
      getinfo.ostan.value,
    );
  }

  test() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "!!! توجه",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
        content: const Text(
          'تمامی فیلدها پر شود',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "متوجه شدم",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('_dl.UserId.value : ${_dl.UserId.value}');
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: size.width * 0.9,
        height: size.height * 0.065,
        child: FloatingActionButton(
          onPressed: () {
            if (isClickedButton == true) {
              print('غیر مجاز');
            } else if (roleBloc?.state is RoleScreenLoading) {
              return;
            } else if (gender!.isNotEmpty &&
                controlfname.text.isNotEmpty &&
                controllname.text.isNotEmpty &&
                controlcode.text.isNotEmpty &&
                controlemail.text.isNotEmpty &&
                getinfo.ostan.value.isNotEmpty &&
                getinfo.city.value.isNotEmpty &&
                controlcodeposti.text.isNotEmpty) {
              setState(
                () {
                  roleBloc?.add(
                    RoleScreenClickButton(
                      Ui_UserUpdateDto(
                        ui_gender.toString(),
                        '',
                        '',
                        '',
                        0,
                        0,
                        0,
                        0,
                        '',
                        '',
                      ),
                    ),
                  );
                  isClickedButton = true;
                  _dl.FName.value = controlfname.text;
                  _dl.LName.value = controllname.text;
                  _dl.NastinalCode.value = controlcode.text;
                  _dl.Email.value = controlemail.text;
                  _dl.PostalCode.value = int.parse(controlcodeposti.text);
                  _dl.Role.value = gender!;
                },
              );
            } else {
              test();
            }
          },

          // onPressed: () {
          //   roleBloc?.add(RoleScreenClickButton(Ui_UserUpdateDto(
          //       ui_gender.toString(), '', '', '', 0, 0, 0, 0, '', '')));
          // },
          child: roleBloc?.state is RoleScreenLoading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text('ادامه'),
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
      body: BlocProvider<RoleScreenBloc>(
        create: (context) {
          final bloc = RoleScreenBloc(roleScreenRepository);
          roleBloc = bloc;
          streamSubscription = bloc.stream.listen((state) {
            // setState(() {
            //   stateSuccess = state is RoleScreenSuccess;
            // });
            if (state is RoleScreenSuccess) {
              EditDl(
                EditDlDto(
                  controlfname.text,
                  controllname.text,
                  controlemail.text,
                  int.parse(controlcode.text.toEnglishDigit()),
                  getinfo.ostanid.value,
                  getinfo.cityid.value,
                  int.parse(controlcodeposti.text.toEnglishDigit()),
                  getinfo.city.value,
                  getinfo.ostan.value,
                ),
              );

              putregistermemberlevel(4, '4', 'Map');
            }
          });

          bloc.add(RoleScreenStarted());
          return bloc;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: BlocBuilder<RoleScreenBloc, RoleScreenState>(
                buildWhen: (previous, current) {
              return current is RoleScreenLoading ||
                  current is RoleScreenInitial ||
                  current is RoleScreenError;
            }, builder: (context, state) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: WillPopScope(
                  onWillPop: () {
                    //we need to return a future
                    return Future.value(false);
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'توجه:',
                                  style: TextStyle(color: Colors.red),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('پر کردن تمامی موارد الزامیست'),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                                'درخواست چه نقش هایی در خانواده عالیس را دارید؟'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(20),
                          ), //BoxDecoration

                          /** CheckboxListTile Widget **/
                          child: RadioListTile(
                            title: const Text('فروشنده'),
                            subtitle: const Text(
                              'به زودی توضیحات اضافه میشود',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            value: "فروشنده",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                                ui_gender = 'seller';
                              });
                            },
                          ),
                        ), //Container
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(20),
                          ), //BoxDecoration

                          /** CheckboxListTile Widget **/
                          child: RadioListTile(
                            title: const Text('ویزیتور'),
                            subtitle: const Text(
                              'به زودی توضیحات اضافه میشود',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            value: "ویزیتور",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                                ui_gender = 'visitor';
                              });
                            },
                          ), //CheckboxListTile
                        ), //Container
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(20),
                          ), //BoxDecoration

                          /** CheckboxListTile Widget **/
                          child: RadioListTile(
                            title: const Text('موزع'),
                            subtitle: const Text(
                              'به زودی توضیحات اضافه میشود',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            value: "موزع",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                                ui_gender = 'distpacher';
                              });
                            },
                          ), //CheckboxListTile
                        ), //Container
                      ),
                      if (gender == 'فروشنده')
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: SizedBox(
                            height: size.height * 0.89,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Titr('اطلاعات فروشنده'),
                                  TextForm(controlfname, 'نام'),
                                  TextForm(controllname, 'نام خانوادگی'),
                                  TextForm(controlcode, 'کد ملی'),
                                  TextForm(controlemail, 'ایمیل'),
                                  Titr('اطلاعات تماس'),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownSearch<EparchyModel>(
                                      dropdownDecoratorProps:
                                          const DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          labelText: 'استان',
                                          // hintText: "country in menu mode",
                                        ),
                                      ),
                                      // dropdownSearchDecoration: InputDecoration(labelText: "Name"),

                                      asyncItems: (String filter) async {
                                        var response = await httpClient
                                            .get('Const/eparchy');
                                        var models = EparchyModel.fromJsonList(
                                            response.data);
                                        return models;
                                      },

                                      onChanged: (EparchyModel? eparchy) {
                                        getinfo.ostan.value =
                                            eparchy!.EparchyTitle.toString();
                                        getinfo.ostanid.value =
                                            eparchy.EparchyId;
                                        _dl.Ostan.value =
                                            eparchy.EparchyTitle.toString();
                                        // _selected =
                                        //     CityModel(CityId: 0, CityName: cityInfo.city.value);
                                        setState(() {
                                          _selected = CityModel(
                                              CityId: 0,
                                              CityName:
                                                  'لطفا شهر خود را انتخاب نمایید');
                                          data.clear();
                                          data.add(DropdownSearch<CityModel>(
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                labelText: 'شهر',

                                                // hintText: "country in menu mode",
                                              ),
                                            ),
                                            // dropdownSearchDecoration: InputDecoration(labelText: "Name"),
                                            selectedItem: _selected,

                                            asyncItems: (String filter) async {
                                              var response = await httpClient
                                                  .get('Const/City/city',
                                                      queryParameters: {
                                                    "EparchyId":
                                                        getinfo.ostanid.value
                                                  });
                                              var models =
                                                  CityModel.fromJsonList(
                                                      response.data);
                                              return models;
                                            },

                                            onChanged: (CityModel? citymodel) {
                                              getinfo.city.value = citymodel!
                                                  .CityName
                                                  .toString();
                                              getinfo.cityid.value =
                                                  citymodel.CityId;
                                              _dl.City.value =
                                                  citymodel.CityName.toString();
                                            },
                                          ));
                                        });
                                      },
                                    ),
                                  ),
                                  data[0],
                                  TextForm(controlcodeposti, 'کد پستی'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (gender == 'ویزیتور')
                        SizedBox(
                          height: size.height * 0.84,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Titr('اطلاعات ویزیتور'),
                                TextForm(controlfname, 'نام'),
                                TextForm(controllname, 'نام خانوادگی'),
                                TextForm(controlcode, 'کد ملی'),
                                TextForm(controlemail, 'ایمیل'),
                                Titr('اطلاعات تماس'),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownSearch<EparchyModel>(
                                    dropdownDecoratorProps:
                                        const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                        labelText: 'استان',
                                        // hintText: "country in menu mode",
                                      ),
                                    ),
                                    // dropdownSearchDecoration: InputDecoration(labelText: "Name"),

                                    asyncItems: (String filter) async {
                                      var response =
                                          await httpClient.get('Const/eparchy');
                                      var models = EparchyModel.fromJsonList(
                                          response.data);
                                      return models;
                                    },

                                    onChanged: (EparchyModel? eparchy) {
                                      getinfo.ostan.value =
                                          eparchy!.EparchyTitle.toString();
                                      getinfo.ostanid.value = eparchy.EparchyId;
                                      _dl.Ostan.value =
                                          eparchy.EparchyTitle.toString();
                                      // _selected =
                                      //     CityModel(CityId: 0, CityName: cityInfo.city.value);
                                      setState(() {
                                        _selected = CityModel(
                                            CityId: 0,
                                            CityName:
                                                'لطفا شهر خود را انتخاب نمایید');
                                        data.clear();
                                        data.add(DropdownSearch<CityModel>(
                                          dropdownDecoratorProps:
                                              const DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              labelText: 'شهر',

                                              // hintText: "country in menu mode",
                                            ),
                                          ),
                                          // dropdownSearchDecoration: InputDecoration(labelText: "Name"),
                                          selectedItem: _selected,

                                          asyncItems: (String filter) async {
                                            var response = await httpClient.get(
                                                'Const/City/city',
                                                queryParameters: {
                                                  "EparchyId":
                                                      getinfo.ostanid.value
                                                });
                                            var models = CityModel.fromJsonList(
                                                response.data);
                                            return models;
                                          },

                                          onChanged: (CityModel? citymodel) {
                                            getinfo.city.value =
                                                citymodel!.CityName.toString();
                                            getinfo.cityid.value =
                                                citymodel.CityId;
                                            _dl.City.value =
                                                citymodel.CityName.toString();
                                          },
                                        ));
                                      });
                                    },
                                  ),
                                ),
                                data[0],
                                TextForm(controlcodeposti, 'کد پستی'),
                              ],
                            ),
                          ),
                        ),
                      if (gender == 'موزع')
                        SizedBox(
                          height: size.height * 0.84,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Titr('اطلاعات موزع'),
                                TextForm(controlfname, 'نام'),
                                TextForm(controllname, 'نام خانوادگی'),
                                TextForm(controlcode, 'کد ملی'),
                                TextForm(controlemail, 'ایمیل'),
                                Titr('اطلاعات تماس'),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownSearch<EparchyModel>(
                                    dropdownDecoratorProps:
                                        const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                        labelText: 'استان',
                                        // hintText: "country in menu mode",
                                      ),
                                    ),
                                    // dropdownSearchDecoration: InputDecoration(labelText: "Name"),

                                    asyncItems: (String filter) async {
                                      var response =
                                          await httpClient.get('Const/eparchy');
                                      var models = EparchyModel.fromJsonList(
                                          response.data);
                                      return models;
                                    },

                                    onChanged: (EparchyModel? eparchy) {
                                      getinfo.ostan.value =
                                          eparchy!.EparchyTitle.toString();
                                      getinfo.ostanid.value = eparchy.EparchyId;
                                      _dl.Ostan.value =
                                          eparchy.EparchyTitle.toString();
                                      // _selected =
                                      //     CityModel(CityId: 0, CityName: cityInfo.city.value);
                                      setState(() {
                                        _selected = CityModel(
                                            CityId: 0,
                                            CityName:
                                                'لطفا شهر خود را انتخاب نمایید');
                                        data.clear();
                                        data.add(DropdownSearch<CityModel>(
                                          dropdownDecoratorProps:
                                              const DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              labelText: 'شهر',

                                              // hintText: "country in menu mode",
                                            ),
                                          ),
                                          // dropdownSearchDecoration: InputDecoration(labelText: "Name"),
                                          selectedItem: _selected,

                                          asyncItems: (String filter) async {
                                            var response = await httpClient.get(
                                                'Const/City/city',
                                                queryParameters: {
                                                  "EparchyId":
                                                      getinfo.ostanid.value
                                                });
                                            var models = CityModel.fromJsonList(
                                                response.data);
                                            return models;
                                          },

                                          onChanged: (CityModel? citymodel) {
                                            getinfo.city.value =
                                                citymodel!.CityName.toString();
                                            getinfo.cityid.value =
                                                citymodel.CityId;
                                            _dl.City.value =
                                                citymodel.CityName.toString();
                                          },
                                        ));
                                      });
                                    },
                                  ),
                                ),
                                data[0],
                                TextForm(controlcodeposti, 'کد پستی'),
                              ],
                            ),
                          ),
                        ),

                      //////////////////////////////////////////////////////////////////////////////////////////////
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
