import 'dart:convert';
import 'dart:io';
import 'package:local_notification_flutter_project/ui/data/repo/add_newstore_repository.dart';
import 'package:local_notification_flutter_project/ui/models/data_settings_store.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/NewStore/bloc/new_store_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewStore extends StatefulWidget {
  const NewStore({
    Key? key,
    required this.active,
    required this.number,
    this.product,
  }) : super(key: key);

  final bool active;
  final int number;
  final List<Product7>? product;
  @override
  State<NewStore> createState() => _NewStoreState();
}

class _NewStoreState extends State<NewStore> {
  @override
  void initState() {
    super.initState();
  }

  final picker1 = ImagePicker();

  String? _image1, branch;
  File? _file1;

  getimage() {
    setState(() async {
      final pickedFile = await picker1.getImage(source: ImageSource.camera);
      if (pickedFile != null) {
        _file1 = File(pickedFile.path);
        List<int> bytes = utf8.encode(pickedFile.path);
        final imageEncoded = base64.encode(bytes);
        _image1 = imageEncoded;

        ///Check Size Image
        final _bytes = _file1!.readAsBytesSync().lengthInBytes;
        double K = ((_bytes / 1024.0));
        double m = ((_bytes / 1024.0) / 1024.0);
        // print('K: ${K}');
        // print('m: ${m}');
        if (m > 5) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 3),
              content: Text('حجم عکس نباید بیشتر از 5 مگا بایت باشد'),
            ),
          );
        }
      } else {
        print('No image selected.');
      }
    });
  }

  final List<String> items = [
    'شعبه اصلی',
    'شعبه جدید',
    'شعبه 1',
    'شعبه 2',
    'شعبه 3',
  ];
  String? _selectedLocation; // Option 2
  final TextEditingController nameStore = TextEditingController();
  final TextEditingController phoneStore = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController branchtype = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final product = Get.arguments;
    final isactive = widget.active;
    // if (isactive == true) {
    // nameStore.text = product.title;
    // phoneStore.text = product.title7;
    // address.text = product.title9;
    // branchtype.text = product.title2;
    // }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider<NewStoreBloc>(
          create: (context) {
            final bloc = NewStoreBloc(addStoreRepository: addStoreRepository);

            bloc.add(NewStoreStarted());
            return bloc;
          },
          child: SafeArea(
            child: BlocBuilder<NewStoreBloc, NewStoreState>(
              builder: (context, state) {
                if (state is NewStoreSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('اطلاعات با موفقیت ارسال شد'),
                    ),
                  );
                  Navigator.of(context).pop();
                } else if (state is NewStoreError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('خطا در ارسال'),
                    ),
                  );
                }
                return Column(
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.2,

                      // color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 20, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'بارگزاری مدارک فروشگاه :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'مدرک خواسته شده را با رعایت شفاف بودن و کامل بودن تصویر بارگزاری فرمایید ',
                              style: TextStyle(color: Colors.black45),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'توجه:',
                              style: TextStyle(color: Colors.red, fontSize: 10),
                            ),
                            Text(
                              'دقت فرمایید در تصویر جزئیات اضافه نباشد و فقط تصویر مدرک ارسال شود',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black45),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: Column(
                        children: [
                          isactive == true
                              ? Row(
                                  children: const [
                                    Text(
                                      'نام فروشگاه',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(''),
                          TextField(
                            controller: nameStore,
                            style: const TextStyle(
                                fontFamily: 'IransansDn',
                                fontSize: 10,
                                color: Colors.blue),
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              labelText: isactive ? null : 'نام فروشگاه',
                              hintText: isactive ? product.title : null,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          isactive == true
                              ? Row(
                                  children: const [
                                    Text(
                                      'شماره تماس',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(''),
                          TextField(
                            controller: phoneStore,
                            style: const TextStyle(
                                fontFamily: 'IransansDn',
                                fontSize: 10,
                                color: Colors.blue),
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              labelText: isactive ? null : 'شماره تماس',
                              hintText: isactive ? product.title7 : null,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          isactive == true
                              ? Row(
                                  children: const [
                                    Text(
                                      'آدرس',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(''),
                          TextField(
                            controller: address,
                            style: const TextStyle(
                                fontFamily: 'IransansDn',
                                fontSize: 10,
                                color: Colors.blue),
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              labelText: isactive ? null : 'آدرس',
                              hintText: isactive ? product.title9 : null,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: size.width * 0.85,
                            child: DropdownButton(
                              isExpanded: true,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                              hint: isactive
                                  ? Text(product.title2)
                                  : const Text(
                                      'انتخاب نوع شعبه'), // Not necessary for Option 1
                              value: _selectedLocation,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedLocation = newValue as String?;
                                });
                              },
                              items: items.map((location) {
                                return DropdownMenuItem(
                                  value: location,
                                  child: Text(location),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                      child: Container(
                        width: size.width * 0.9,
                        height: size.height * 0.12,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
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
                                : Image.file(
                                    _file1!,
                                    width: size.width * 0.16,
                                  ),
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
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    getimage();
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'بارگزاری تصویر',
                                        style: TextStyle(color: Colors.blue),
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
                      height: 10,
                    ),

                    Container(
                      width: size.width * 0.9,
                      height: size.height * 0.06,
                      margin: const EdgeInsets.only(bottom: 5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                        ),
                        onPressed: () {
                          if (isactive == true) {
                            BlocProvider.of<NewStoreBloc>(context).add(
                              NewStoreClickedButton(
                                name: nameStore.text == ''
                                    ? product.title
                                    : nameStore.text,
                                address: address.text == ''
                                    ? product.title9
                                    : address.text,
                                image: _file1 == null ? '' : _image1!,
                                branchtype: _selectedLocation ?? product.title,
                                phoneNumber: phoneStore.text.isEmpty
                                    ? int.parse(product.title7)
                                    : int.parse(phoneStore.text),
                                isactive: isactive,
                              ),
                            );
                          } else {
                            BlocProvider.of<NewStoreBloc>(context).add(
                              NewStoreClickedButton(
                                name: nameStore.text,
                                address: address.text,
                                image: _image1!,
                                branchtype: _selectedLocation!,
                                phoneNumber: int.parse(phoneStore.text),
                                isactive: isactive,
                              ),
                            );
                          }

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (Contex) => Directionality(
                          //       textDirection: TextDirection.rtl,
                          //       child: Settings_Store(),
                          //     ),
                          //   ),
                          // );
                        },
                        child: isactive
                            ? state is NewStoreLoading
                                ? const CupertinoActivityIndicator()
                                : const Text(
                                    'ویرایش اطلاعات',
                                    style: TextStyle(fontFamily: 'IransansDn'),
                                  )
                            : state is NewStoreLoading
                                ? const CupertinoActivityIndicator()
                                : const Text(
                                    'ارسال درخواست',
                                    style: TextStyle(fontFamily: 'IransansDn'),
                                  ),
                      ),
                    ),
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
