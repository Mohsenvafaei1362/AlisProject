import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/documents_repository.dart';
import 'package:local_notification_flutter_project/ui/models/Dto/DocumentsDto.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Documents/bloc/documents_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class Documents extends StatefulWidget {
  const Documents({Key? key}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

final UiAddressIp getAddress2 = Get.put(UiAddressIp());
final UiDl _dl = Get.put(UiDl());
final UiPhoneController _phoneNumber = Get.put(UiPhoneController());

DocumentsBloc? documentsBloc;

class _DocumentsState extends State<Documents> {
  final UiPhoneController phoneController = Get.put(UiPhoneController());
  final UiShowInfo showInfo = Get.put(UiShowInfo());
  final UiTimerUser timerUser = Get.put(UiTimerUser());
  // final UiFlag flag = Get.put(UiFlag());
  final picker1 = ImagePicker();
  final picker2 = ImagePicker();
  final picker3 = ImagePicker();
  final picker4 = ImagePicker();

  String? _image1;
  String? _image2;
  String? _image3;
  String? _image4;
  File? _file1;
  File? _file2;
  File? _file3;
  File? _file4;

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
          showDialog(
            context: context,
            builder: ((context) => Dialog(
                context: context,
                warning: '!!! توجه',
                title:
                    'حجم عکس نباید بیشتر از 5 مگا بایت باشد'.toPersianDigit(),
                button: 'متوجه شدم')),
          );
        } else {
          documentsBloc?.add(
            DocumentsClickButton(
              UiDocumentsInfo(
                modelId: 1,
                userRef: _dl.UserId.value,
                dlRef: _dl.DlId.value,
                desc: '',
                phoneNumber: _phoneNumber.phone.value,
                registerLevelRef: _dl.RegisterLevelCode.value,
                ModelTitle: 'NationalCardFront',
                pic: _image1!,
                tableRef: 1,
                tableTitle: '',
                Creator: _dl.UserId.value,
              ),
            ),
          );
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
          showDialog(
            context: context,
            builder: ((context) => Dialog(
                context: context,
                warning: '!!! توجه',
                title:
                    'حجم عکس نباید بیشتر از 5 مگا بایت باشد'.toPersianDigit(),
                button: 'متوجه شدم')),
          );
        } else {
          documentsBloc?.add(
            DocumentsClickButton(
              UiDocumentsInfo(
                modelId: 1,
                userRef: _dl.UserId.value,
                dlRef: _dl.DlId.value,
                desc: '',
                phoneNumber: _phoneNumber.phone.value,
                registerLevelRef: _dl.RegisterLevelCode.value,
                ModelTitle: 'NationalCardFront',
                pic: _image1!,
                tableRef: 1,
                tableTitle: '',
                Creator: _dl.UserId.value,
              ),
            ),
          );
        }
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage2() async {
    final pickedFile2 = await picker2.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile2 != null) {
        _file2 = File(pickedFile2.path);
        List<int> bytes = utf8.encode(pickedFile2.path);
        final imageEncoded = base64.encode(bytes);
        _image2 = imageEncoded;

        ///Check Size Image
        final _bytes = _file1!.readAsBytesSync().lengthInBytes;
        double m = ((_bytes / 1024.0) / 1024.0);
        if (m > 5) {
          showDialog(
            context: context,
            builder: ((context) => Dialog(
                context: context,
                warning: '!!! توجه',
                title:
                    'حجم عکس نباید بیشتر از 5 مگا بایت باشد'.toPersianDigit(),
                button: 'متوجه شدم')),
          );
        } else {
          documentsBloc?.add(
            DocumentsClickButton(
              UiDocumentsInfo(
                modelId: 2,
                userRef: _dl.UserId.value,
                dlRef: _dl.DlId.value,
                desc: '',
                phoneNumber: _phoneNumber.phone.value,
                registerLevelRef: _dl.RegisterLevelCode.value,
                ModelTitle: 'NationalCardBack',
                pic: _image2!,
                tableRef: 1,
                tableTitle: '',
                Creator: _dl.UserId.value,
              ),
            ),
          );
        }
      } else {
        print('No image selected.');
      }
    });
  }

  Future getgallery2() async {
    final pickedFile2 = await picker1.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile2 != null) {
        _file2 = File(pickedFile2.path);
        List<int> bytes = utf8.encode(pickedFile2.path);
        final imageEncoded = base64.encode(bytes);
        _image2 = imageEncoded;

        ///Check Size Image
        final _bytes = _file1!.readAsBytesSync().lengthInBytes;
        double m = ((_bytes / 1024.0) / 1024.0);
        if (m > 5) {
          showDialog(
            context: context,
            builder: ((context) => Dialog(
                context: context,
                warning: '!!! توجه',
                title:
                    'حجم عکس نباید بیشتر از 5 مگا بایت باشد'.toPersianDigit(),
                button: 'متوجه شدم')),
          );
        } else {
          documentsBloc?.add(
            DocumentsClickButton(
              UiDocumentsInfo(
                modelId: 2,
                userRef: _dl.UserId.value,
                dlRef: _dl.DlId.value,
                desc: '',
                phoneNumber: _phoneNumber.phone.value,
                registerLevelRef: _dl.RegisterLevelCode.value,
                ModelTitle: 'NationalCardBack',
                pic: _image2!,
                tableRef: 1,
                tableTitle: '',
                Creator: _dl.UserId.value,
              ),
            ),
          );
        }
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage3() async {
    final pickedFile3 = await picker3.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile3 != null) {
        _file3 = File(pickedFile3.path);
        List<int> bytes = utf8.encode(pickedFile3.path);
        final imageEncoded = base64.encode(bytes);
        _image3 = imageEncoded;

        ///Check Size Image
        final _bytes = _file1!.readAsBytesSync().lengthInBytes;
        double m = ((_bytes / 1024.0) / 1024.0);
        if (m > 5) {
          showDialog(
            context: context,
            builder: ((context) => Dialog(
                context: context,
                warning: '!!! توجه',
                title:
                    'حجم عکس نباید بیشتر از 5 مگا بایت باشد'.toPersianDigit(),
                button: 'متوجه شدم')),
          );
        } else {
          documentsBloc?.add(
            DocumentsClickButton(
              UiDocumentsInfo(
                modelId: 3,
                userRef: _dl.UserId.value,
                dlRef: _dl.DlId.value,
                desc: '',
                phoneNumber: _phoneNumber.phone.value,
                registerLevelRef: _dl.RegisterLevelCode.value,
                ModelTitle: 'License',
                pic: _image3!,
                tableRef: 1,
                tableTitle: '',
                Creator: _dl.UserId.value,
              ),
            ),
          );
        }
      } else {
        print('No image selected.');
      }
    });
  }

  Future getgallery3() async {
    final pickedFile3 = await picker1.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile3 != null) {
        _file3 = File(pickedFile3.path);
        List<int> bytes = utf8.encode(pickedFile3.path);
        final imageEncoded = base64.encode(bytes);
        _image3 = imageEncoded;

        ///Check Size Image
        final _bytes = _file1!.readAsBytesSync().lengthInBytes;
        double m = ((_bytes / 1024.0) / 1024.0);
        if (m > 5) {
          showDialog(
            context: context,
            builder: ((context) => Dialog(
                context: context,
                warning: '!!! توجه',
                title:
                    'حجم عکس نباید بیشتر از 5 مگا بایت باشد'.toPersianDigit(),
                button: 'متوجه شدم')),
          );
        } else {
          documentsBloc?.add(
            DocumentsClickButton(
              UiDocumentsInfo(
                modelId: 3,
                userRef: _dl.UserId.value,
                dlRef: _dl.DlId.value,
                desc: '',
                phoneNumber: _phoneNumber.phone.value,
                registerLevelRef: _dl.RegisterLevelCode.value,
                ModelTitle: 'License',
                pic: _image3!,
                tableRef: 1,
                tableTitle: '',
                Creator: _dl.UserId.value,
              ),
            ),
          );
        }
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage4() async {
    final pickedFile4 = await picker4.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile4 != null) {
        _file4 = File(pickedFile4.path);
        List<int> bytes = utf8.encode(pickedFile4.path);
        final imageEncoded = base64.encode(bytes);
        _image4 = imageEncoded;

        ///Check Size Image
        final _bytes = _file1!.readAsBytesSync().lengthInBytes;
        double m = ((_bytes / 1024.0) / 1024.0);
        if (m > 5) {
          showDialog(
            context: context,
            builder: ((context) => Dialog(
                context: context,
                warning: '!!! توجه',
                title:
                    'حجم عکس نباید بیشتر از 5 مگا بایت باشد'.toPersianDigit(),
                button: 'متوجه شدم')),
          );
        } else {
          documentsBloc?.add(
            DocumentsClickButton(
              UiDocumentsInfo(
                modelId: 4,
                userRef: _dl.UserId.value,
                dlRef: _dl.DlId.value,
                desc: '',
                phoneNumber: _phoneNumber.phone.value,
                registerLevelRef: _dl.RegisterLevelCode.value,
                ModelTitle: 'BirthCertificate',
                pic: _image4!,
                tableRef: 1,
                tableTitle: '',
                Creator: _dl.UserId.value,
              ),
            ),
          );
        }
      } else {
        print('No image selected.');
      }
    });
  }

  Future getgallery4() async {
    final pickedFile4 = await picker1.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile4 != null) {
        _file4 = File(pickedFile4.path);
        List<int> bytes = utf8.encode(pickedFile4.path);
        final imageEncoded = base64.encode(bytes);
        _image4 = imageEncoded;

        ///Check Size Image
        final _bytes = _file1!.readAsBytesSync().lengthInBytes;
        double m = ((_bytes / 1024.0) / 1024.0);
        if (m > 5) {
          showDialog(
            context: context,
            builder: ((context) => Dialog(
                context: context,
                warning: '!!! توجه',
                title:
                    'حجم عکس نباید بیشتر از 5 مگا بایت باشد'.toPersianDigit(),
                button: 'متوجه شدم')),
          );
        } else {
          documentsBloc?.add(
            DocumentsClickButton(
              UiDocumentsInfo(
                modelId: 4,
                userRef: _dl.UserId.value,
                dlRef: _dl.DlId.value,
                desc: '',
                phoneNumber: _phoneNumber.phone.value,
                registerLevelRef: _dl.RegisterLevelCode.value,
                ModelTitle: 'BirthCertificate',
                pic: _image4!,
                tableRef: 1,
                tableTitle: '',
                Creator: _dl.UserId.value,
              ),
            ),
          );
        }
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    documentsBloc?.close();
  }

  checkImage() {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
          context: context,
          button: 'متوجه شدم',
          warning: '!!! توجه ',
          title: 'تمامی فیلدها پر شوند'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider<DocumentsBloc>(
          create: (context) {
            final bloc = DocumentsBloc(documentsRepository);
            bloc.add(DocumentsStarted());
            documentsBloc = bloc;
            return bloc;
          },
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: BlocBuilder<DocumentsBloc, DocumentsState>(
                // buildWhen: (previous, current) {
                //   return current is DocumentsLoading ||
                //       current is DocumentsInitial ||
                //       current is DocumentsError;
                // },
                builder: (context, state) {
                  // if (state is DocumentsSuccess) {
                  return WillPopScope(
                    onWillPop: () {
                      //we need to return a future
                      return Future.value(false);
                    },
                    child: Column(
                      children: [
                        // Image.memory(_byteImage),
                        SizedBox(
                          width: size.width,
                          height: size.height / 4.2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 36, 24, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'بارگزاری مدارک :',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'مدارک خواسته شده را با رعایت شفاف بودن و کامل بودن تصویر بارگزاری فرمایید ',
                                  style: TextStyle(color: Colors.black45),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'توجه:',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 10),
                                ),
                                Text(
                                  'دقت فرمایید در تصویر جزئیات اضافه نباشد و فقط تصویر مدارک ارسال شود',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black45),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: Container(
                            width: size.width / 1.2,
                            height: 100,
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.black),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _file1 == null
                                    ? Image.asset(
                                        'assets/images/upload.png',
                                        width: 68,
                                        height: 68,
                                      )
                                    : Image.file(_file1!),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'کارت ملی',
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 110,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: InkWell(
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
                                                      // getgallery();
                                                      // getmadrak();
                                                      getgallery();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      width: size.width * 0.2,
                                                      height:
                                                          size.height * 0.05,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'گالری',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      getImage();
                                                      Navigator.of(context)
                                                          .pop();
                                                      // getmadrak();
                                                    },
                                                    child: Container(
                                                      width: size.width * 0.2,
                                                      height:
                                                          size.height * 0.05,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'دوربین',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                        child: Center(
                                          child: state is DocumentsLoading
                                              ? const CupertinoActivityIndicator(
                                                  color: Colors.black,
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: const [
                                                    Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: Colors.blue,
                                                      size: 23,
                                                    ),
                                                    // SizedBox(
                                                    //   width: 5,
                                                    // ),
                                                    Text(
                                                      'بارگزاری تصویر',
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: Container(
                            width: size.width / 1.2,
                            height: 100,
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.black),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _file2 == null
                                    ? Image.asset(
                                        'assets/images/upload.png',
                                        width: 68,
                                        height: 68,
                                      )
                                    : Image.file(_file2!),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'پشت کارت ملی',
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 110,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: InkWell(
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
                                                      getgallery2();
                                                      Navigator.of(context)
                                                          .pop();
                                                      // getmadrak();
                                                    },
                                                    child: Container(
                                                      width: size.width * 0.2,
                                                      height:
                                                          size.height * 0.05,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'گالری',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      getImage2();
                                                      Navigator.of(context)
                                                          .pop();
                                                      // getmadrak();
                                                    },
                                                    child: Container(
                                                      width: size.width * 0.2,
                                                      height:
                                                          size.height * 0.05,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'دوربین',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                        child: Center(
                                          child: state is DocumentsLoading
                                              ? const CupertinoActivityIndicator(
                                                  color: Colors.black,
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: const [
                                                    Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: Colors.blue,
                                                      size: 23,
                                                    ),
                                                    // SizedBox(
                                                    //   width: 5,
                                                    // ),
                                                    Text(
                                                      'بارگزاری تصویر',
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: Container(
                            width: size.width / 1.2,
                            height: 100,
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.black),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _file3 == null
                                    ? Image.asset(
                                        'assets/images/upload.png',
                                        width: 68,
                                        height: 68,
                                      )
                                    : Image.file(_file3!),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'جواز کسب',
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 110,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: InkWell(
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
                                                      getgallery3();
                                                      Navigator.of(context)
                                                          .pop();
                                                      // getmadrak();
                                                    },
                                                    child: Container(
                                                      width: size.width * 0.2,
                                                      height:
                                                          size.height * 0.05,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'گالری',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      getImage3();
                                                      Navigator.of(context)
                                                          .pop();
                                                      // getmadrak();
                                                    },
                                                    child: Container(
                                                      width: size.width * 0.2,
                                                      height:
                                                          size.height * 0.05,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'دوربین',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                        child: Center(
                                          child: state is DocumentsLoading
                                              ? const CupertinoActivityIndicator(
                                                  color: Colors.black,
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: const [
                                                    Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: Colors.blue,
                                                      size: 23,
                                                    ),
                                                    // SizedBox(
                                                    //   width: 5,
                                                    // ),
                                                    Text(
                                                      'بارگزاری تصویر',
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: Container(
                            width: size.width / 1.2,
                            height: 100,
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.black),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _file4 == null
                                    ? Image.asset(
                                        'assets/images/upload.png',
                                        width: 68,
                                        height: 68,
                                      )
                                    : Image.file(_file4!),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'صفحه اول شناسنامه',
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 110,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: InkWell(
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
                                                      getgallery4();
                                                      Navigator.of(context)
                                                          .pop();
                                                      // getmadrak();
                                                    },
                                                    child: Container(
                                                      width: size.width * 0.2,
                                                      height:
                                                          size.height * 0.05,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'گالری',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      getImage4();
                                                      Navigator.of(context)
                                                          .pop();
                                                      // getmadrak();
                                                    },
                                                    child: Container(
                                                      width: size.width * 0.2,
                                                      height:
                                                          size.height * 0.05,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'دوربین',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                        child: Center(
                                          child: state is DocumentsLoading
                                              ? const CupertinoActivityIndicator(
                                                  color: Colors.black,
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: const [
                                                    Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: Colors.blue,
                                                      size: 23,
                                                    ),
                                                    // SizedBox(
                                                    //   width: 5,
                                                    // ),
                                                    Text(
                                                      'بارگزاری تصویر',
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: size.width * 0.9,
                          height: size.height * 0.06,
                          margin: const EdgeInsets.only(bottom: 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                            ),
                            onPressed: () {
                              if (state is DocumentsLoading) {
                                return;
                              } else if (_file1 == null ||
                                  _file2 == null ||
                                  _file3 == null ||
                                  _file4 == null) {
                                checkImage();
                              } else {
                                // putregistermemberlevel(5, '5', "PreviewInfo");
                                state is DocumentsLoading
                                    ? const CupertinoActivityIndicator(
                                        color: Colors.black,
                                      )
                                    : BlocProvider.of<DocumentsBloc>(context)
                                        .add(
                                        DocumentsNextPage(),
                                      );
                              }
                            },
                            child: state is DocumentsLoading
                                ? const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'بعدی',
                                    style: TextStyle(fontFamily: 'IransansDn'),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                  // } else if (state is DocumentsLoading) {
                  //   return const Center(
                  //     child: CupertinoActivityIndicator(),
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

class Dialog extends StatelessWidget {
  const Dialog({
    Key? key,
    required this.context,
    required this.warning,
    required this.title,
    required this.button,
  }) : super(key: key);

  final BuildContext context;
  final String warning;
  final String title;
  final String button;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        warning,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.amber,
        ),
      ),
      content: Text(
        title,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              button,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
