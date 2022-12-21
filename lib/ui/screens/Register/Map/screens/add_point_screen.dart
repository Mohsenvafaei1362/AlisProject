import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:local_notification_flutter_project/ui/data/repo/add_point_screen_repository.dart';
import 'package:local_notification_flutter_project/ui/models/register/putregistermemberlevel.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/DB/boxes.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/models/point_location_model.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/providers/point_provider.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/screens/bloc/add_point_screen_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/widgets/image_widget.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/widgets/location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/AlertDialog.dart';
import 'package:provider/provider.dart';
// import 'package:point_app/DB/boxes.dart';
// import 'package:point_app/DB/db_helper.dart';
// import 'package:point_app/widgets/image_widget.dart';
// import 'package:point_app/widgets/location_widget.dart';

class Ui_AddPointScreen extends StatefulWidget {
  const Ui_AddPointScreen({Key? key}) : super(key: key);

  @override
  _Ui_AddPointScreenState createState() => _Ui_AddPointScreenState();
}

class _Ui_AddPointScreenState extends State<Ui_AddPointScreen> {
  late final Box box;
  @override
  void initState() {
    Ui_Boxes.getPointsBox().then((value) => box = value);
    super.initState();
  }

  String? image;
  // File? _file;
  AddPointScreenBloc? addPointScreenBloc;

  @override
  void dispose() {
    Hive.close();
    super.dispose();
    addPointScreenBloc?.close();
  }

  final _titleController = TextEditingController();
  File? _image = null;
  Ui_PointLocationModel? _selectedLocation = null;

  void _selectImage(File image) {
    _image = image;
  }

  void _selectLoccation(Ui_PointLocationModel _location) {
    _selectedLocation = _location;
  }

  void _save() async {
    if (_titleController.text.isEmpty ||
        _image == null ||
        _selectedLocation == null) {
      return Alert_Dialog().alert;
    }

    await Provider.of<Ui_PointProvider>(context, listen: false)
        .addPoint(_titleController.text, _image!, _selectedLocation!);

    List<int> bytes = utf8.encode(_image!.path);
    final imageEncoded = base64.encode(bytes);
    image = imageEncoded;

    addPointScreenBloc?.add(AddPointScreenClickedButton(
      title: _titleController.text,
      lat: _selectedLocation!.lat,
      long: _selectedLocation!.lon,
      image: image!,
      RegisterLevelRef: 4,
      RegisterLevelCode: '4',
      RegisterLvelTitle: 'LoginSex',
    ));
    // if (addPointScreenBloc?.state is AddPointScreenSuccess) {
    // }
    putregistermemberlevel(5, '5', 'LoginSix');

    // if (_image != null) {
    //   _file = File(_image!.path);
    //   List<int> bytes = utf8.encode(_image!.path);
    //   final imageEncoded = base64.encode(bytes);
    //   image = imageEncoded;
    // } else {
    //   print('No image selected.');
    // }
    // print(_selectedLocation!.lat.runtimeType);
    // print(_selectedLocation!.lon.runtimeType);
    // print(_titleController.text.runtimeType);
    // print(_image.runtimeType);

    //print(box.getAt(0));

    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.red,
            onPressed: () {
              // if (_titleController.text.length != 0 || _image != null || _selectedLocation != null) {
              addPointScreenBloc!.state is AddPointScreenLoading
                  ? null
                  : _save();
              // } else {
              //   Alert_Dialog().alert;
              // }
            },
            label: Row(
              children: const [
                Text(
                  'ثبت آدرس',
                  style: TextStyle(fontFamily: 'IransansDn'),
                ),
                Icon(Icons.add_location),
              ],
            ),
          ),
          appBar: AppBar(
            centerTitle: false,
            elevation: 2,
            title: Row(
              children: const [
                SizedBox(
                  width: 10,
                ),
                Text(
                  "ثبت مکان",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                )
              ],
            ),
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: BlocProvider<AddPointScreenBloc>(
            create: (context) {
              final bloc = AddPointScreenBloc(addPointScreenRepository);
              addPointScreenBloc = bloc;
              bloc.add(AddPointScreenStarted());
              return bloc;
            },
            child: BlocBuilder<AddPointScreenBloc, AddPointScreenState>(
              buildWhen: (previous, current) {
                return current is AddPointScreenLoading ||
                    current is AddPointScreenInitial ||
                    current is AddPointScreenError;
              },
              builder: (context, state) {
                return WillPopScope(
                  onWillPop: () {
                    //we need to return a future
                    return Future.value(false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                      labelText: "نام فروشگاه",
                                      labelStyle:
                                          TextStyle(fontFamily: 'IransansDn')),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                ImageWidget(
                                  selectImage: _selectImage,
                                ),
                                Divider(
                                  height: 80,
                                  color: Colors.black26,
                                ),
                                LocationWidget(
                                  selectLocation: _selectLoccation,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // ConstrainedBox(
                        //   constraints:
                        //       const BoxConstraints.tightFor(height: 60),
                        //   child: ElevatedButton(
                        //     onPressed:
                        //         state is AddPointScreenLoading ? null : _save,
                        //     child: state is AddPointScreenLoading
                        //         ? const CircularProgressIndicator(
                        //             color: Colors.white,
                        //           )
                        //         : const Text("ثبت"),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
