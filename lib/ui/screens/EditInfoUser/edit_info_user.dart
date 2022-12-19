import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/EditInfoUser_Repository.dart';
import 'package:local_notification_flutter_project/ui/screens/CommentSuggest/commentsuggest.dart';
import 'package:local_notification_flutter_project/ui/screens/EditInfoUser/bloc/edit_info_user_bloc.dart';

class EditInfoUser extends StatefulWidget {
  const EditInfoUser({key});

  @override
  State<EditInfoUser> createState() => _EditInfoUserState();
}

class _EditInfoUserState extends State<EditInfoUser> {
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final UiDl _dl = Get.put(UiDl());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('ویرایش اطلاعات'),
      ),
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          // color: Colors.amber,
          child: BlocProvider<EditInfoUserBloc>(
            create: (context) {
              final bloc = EditInfoUserBloc(
                editInfoUserRepository: editInfoUserRepository,
              );
              bloc.stream.listen((state) {
                if (state is EditInfoUserSuccess) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('اطلاعات با موفقیت ویرایش شد'),
                    ),
                  );
                }
              });
              return bloc;
            },
            child: BlocBuilder<EditInfoUserBloc, EditInfoUserState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Question(
                      question_1: _fname,
                      hint: 'نام',
                    ),
                    Question(
                      question_1: _lname,
                      hint: 'نام خانوادگی',
                    ),
                    Question(
                      question_1: _email,
                      hint: 'ایمیل',
                    ),
                    Question(
                      question_1: _phone,
                      hint: 'تلفن',
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: size.width * 0.9,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_fname.text.length != 0 &&
                                _lname.text.length != 0 &&
                                _email.text.length != 0 &&
                                _phone.text.length != 0) {
                              BlocProvider.of<EditInfoUserBloc>(context).add(
                                EditInfoUserClickedButton(
                                  _fname.text,
                                  _lname.text,
                                  _email.text,
                                  _phone.text,
                                ),
                              );
                            } else {
                              Get.defaultDialog(
                                title: 'کابر گرامی',
                                middleText: ' لطفا تمامی فیلدها پر شوند',
                                middleTextStyle:
                                    TextStyle(color: Colors.pink[300]),
                                onCancel: () {},
                                textCancel: 'متوجه شدم',
                                titleStyle: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          },
                          child: state is EditInfoUserLoading
                              ? CupertinoActivityIndicator()
                              : Text(
                                  'ویرایش',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
