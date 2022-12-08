import 'package:local_notification_flutter_project/ui/data/repo/change_password_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/ChangePassword/bloc/change_password_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late TextEditingController oldpass = TextEditingController();
  late TextEditingController newpass = TextEditingController();
  late TextEditingController repeatenewpass = TextEditingController();

  ChangePasswordBloc? changebloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    changebloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      floatingActionButton: SizedBox(
        width: size.width * 0.9,
        height: size.height * 0.06,
        child: FloatingActionButton(
          onPressed: () {
            changebloc?.add(
              ChangePasswordClickedButton(
                int.parse(oldpass.text),
                int.parse(newpass.text),
              ),
            );
          },
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: changebloc?.state is ChangePasswordLoading
              ? CupertinoActivityIndicator()
              : const Text(
                  'تایید و ذخیره',
                  style: TextStyle(fontFamily: 'IransansDn', fontSize: 12),
                ),
        ),
      ),
      body: BlocProvider<ChangePasswordBloc>(
        create: (context) {
          final bloc = ChangePasswordBloc(
              changePasswordRepository: changePasswordRepository);
          changebloc = bloc;
          bloc.add(ChangePasswordStarted());
          return bloc;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
              builder: (context, state) {
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
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.keyboard_arrow_right),
                          ),
                          const Text('تغییر رمز عبور'),
                          const Icon(Icons.question_mark_rounded),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('رمز عبور فعلی و جدید خود را وارد کنید'),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: oldpass,
                            style: const TextStyle(
                              fontFamily: 'IransansDn',
                              fontSize: 12,
                            ),
                            obscureText: true,
                            decoration: const InputDecoration(
                              // prefixIcon: Icon(Icons.chevron_right_rounded),
                              border: OutlineInputBorder(),
                              labelText: 'رمز عبور فعلی',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                // prefixIcon: Icon(Icons.chevron_right_rounded),
                                border: OutlineInputBorder(),
                                labelText: 'رمز عبور جدید',
                              ),
                              controller: newpass),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: repeatenewpass,
                            style: const TextStyle(
                              fontFamily: 'IransansDn',
                              fontSize: 12,
                            ),
                            obscureText: true,
                            decoration: const InputDecoration(
                              // prefixIcon: Icon(Icons.chevron_right_rounded),
                              border: OutlineInputBorder(),
                              labelText: 'تکرار رمز عبور جدید',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: FlutterPwValidator(
                            controller: newpass,
                            minLength: 8,
                            uppercaseCharCount: 1,
                            numericCharCount: 1,
                            specialCharCount: 1,
                            width: 400,
                            height: 150,
                            onSuccess: () {},
                            onFail: () {},
                          ),
                        ),
                      ],
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
