import 'dart:convert';
import 'dart:io';

import 'package:local_notification_flutter_project/ui/data/repo/complaint_form_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/complaintForm/bloc/complaintform_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({key});

  @override
  State<ComplaintForm> createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController codeOrderController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final List<String> items = [
    'شکایت از پشتیبان',
    'زیاد بودن هزینه ارسال',
    'نمایش اطلاعات اشتباه در حساب کاربری',
    'شکایت از ویزیتور',
    'شکایت از موزع',
    'موضوع جدید',
  ];
  String? selectedValue;
  BuildContext? ctx;

  @override
  void initState() {
    super.initState();
  }

  String? _image1;
  File? _file1;
  final picker1 = ImagePicker();
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
          Get.snackbar(
            'حجم عکس نباید بیشتر از 5 مگا بایت باشد'.toPersianDigit(),
            "",
            padding: const EdgeInsets.only(left: 40, top: 25, right: 40),
            snackPosition: SnackPosition.TOP,
            duration: const Duration(milliseconds: 3000),
          );
        }
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<ComplaintformBloc>(
        create: (context) {
          final bloc =
              ComplaintformBloc(compaintFormRepository: compaintFormRepository);
          bloc.add(ComplaintformStarted());
          return bloc;
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: BlocBuilder<ComplaintformBloc, ComplaintformState>(
              builder: (context, state) {
                // if (state is ComplaintformStarted) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => Directionality(
                                //       textDirection: TextDirection.rtl,
                                //       child: Complaint(),
                                //     ),
                                //   ),
                                // );
                              },
                              child: const Icon(Icons.arrow_back_rounded)),
                          const SizedBox(width: 10),
                          const Text('فرم ثبت شکایت مشتری'),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'تماس با عالیس',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Divider(
                            thickness: 2,
                            indent: 0,
                            endIndent: 350,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            'لطفا پیش از ارسال ایمیل یا تماس تلفنی، ابتدا پرسش های متداول را مشاهده کنید.',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 20),
                          // TextField(
                          //   obscureText: false,
                          //   decoration: InputDecoration(
                          //     prefixIcon: Icon(Icons.chevron_right_rounded),
                          //     border: OutlineInputBorder(),
                          //     labelText: 'موضوع',
                          //     suffixIcon: Icon(
                          //       Icons.star_rate_rounded,
                          //       size: 10,
                          //       color: Colors.red,
                          //     ),
                          //   ),
                          // ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: const Text(
                                    'موضوع درخواست را انتخاب فرمایید',
                                    style: TextStyle(fontFamily: 'IransansDn'),
                                  ),
                                  items: items
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Center(
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontFamily: 'IransansDn',
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value as String;
                                    });
                                  },
                                  buttonHeight: 40,
                                  buttonWidth: 140,
                                  itemHeight: 40,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          TextField(
                            controller: fullnameController,
                            style: const TextStyle(fontFamily: 'IransansDn'),
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'نام و نام خانوادگی',
                              suffixIcon: Icon(
                                Icons.star_rate_rounded,
                                size: 10,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: emailController,
                            style: const TextStyle(fontFamily: 'IransansDn'),
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'ایمیل',
                              // suffixIcon: Icon(
                              //   Icons.star_rate_rounded,
                              //   size: 10,
                              //   color: Colors.red,
                              // ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: phoneNumberController,
                            style: const TextStyle(fontFamily: 'IransansDn'),
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'تلفن تماس',
                              suffixIcon: Icon(
                                Icons.star_rate_rounded,
                                size: 10,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: codeOrderController,
                            style: const TextStyle(fontFamily: 'IransansDn'),
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'شماره سفارش خرید',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: descriptionController,
                            style: const TextStyle(fontFamily: 'IransansDn'),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'توضیحات',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _file1 == null
                                    ? const Padding(
                                        padding: EdgeInsets.all(32),
                                        child: Text(
                                          'حداکثر 5 تصویر jpeg یا PNG حداکثر یک مگابایت، یک ویدیو MP4 حداکثر 50 مگابایت',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(color: Colors.black45),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.file(
                                          _file1!,
                                          fit: BoxFit.cover,
                                          height: size.height * 0.12,
                                        ),
                                      ),
                                const SizedBox(height: 3),
                                InkWell(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Container(
                                    width: size.width / 2.5,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Icon(Icons.cloud_upload),
                                        Text('افزودن عکس یا ویدیو'),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_file1 == null ||
                                    selectedValue == null ||
                                    emailController.text.isEmpty ||
                                    fullnameController.text.isEmpty ||
                                    phoneNumberController.text.isEmpty ||
                                    codeOrderController.text.isEmpty ||
                                    descriptionController.text.isEmpty) {
                                  // checkImage();
                                  Get.snackbar(
                                    'تمامی فیلدها پر شوند',
                                    '',
                                    duration: const Duration(seconds: 3),
                                    padding: EdgeInsets.only(
                                      right: size.width * 0.27,
                                      left: size.width * 0.27,
                                      top: 20,
                                    ),
                                  );
                                } else {
                                  // putregistermemberlevel(5, '5', "PreviewInfo");
                                  BlocProvider.of<ComplaintformBloc>(context)
                                      .add(
                                    ComplaintformClickedButton(
                                      title: selectedValue.toString(),
                                      fullname: fullnameController.text,
                                      email: emailController.text,
                                      phone:
                                          int.parse(phoneNumberController.text),
                                      codeorder:
                                          int.parse(codeOrderController.text),
                                      description: descriptionController.text,
                                      image: _image1.toString(),
                                    ),
                                  );
                                }
                              },
                              child: state is ComplaintformLoading
                                  ? const CupertinoActivityIndicator(
                                      color: Colors.black,
                                    )
                                  : const Text(
                                      'ثبت و ارسال',
                                      style:
                                          TextStyle(fontFamily: 'IransansDn'),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
                // } else if (state is ComplaintformLoading) {
                //   return const Center(
                //     child: CupertinoActivityIndicator(),
                //   );
                // } else if (state is ComplaintformError) {
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
