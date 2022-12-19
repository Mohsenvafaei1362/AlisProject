import 'package:flutter/material.dart';

class CommentSuggest extends StatefulWidget {
  @override
  State<CommentSuggest> createState() => _CommentSuggestState();
}

class _CommentSuggestState extends State<CommentSuggest> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController question_1 = TextEditingController();
  final TextEditingController question_2 = TextEditingController();
  final TextEditingController question_3 = TextEditingController();
  final TextEditingController question_4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.green.shade400,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.keyboard_arrow_right_rounded),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          'نظر سنجی',
                          style: TextStyle(
                            fontFamily: 'IransansDn',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Title(
                        title:
                            'آیا امکانات سایت و اپلیکیشن ما را خوب ارزیابی می کنید',
                      ),
                      Question(
                        question_1: question_1,
                        hint: 'لطفا سوال اول را پاسخ دهید',
                      ),
                      Title(
                          title:
                              'از چه طریقی با سایت و اپلیکیشن عالیس آشنا شده اید'),
                      Question(
                          question_1: question_2,
                          hint: 'لطفا سوال دوم را پاسخ دهید'),
                      Title(
                          title:
                              'کدام محصول عالیس بیشترین مصرف را در خانواده شما دارد'),
                      Question(
                          question_1: question_3,
                          hint: 'لطفا سوال سوم را پاسخ دهید'),
                      Title(
                          title:
                              'اپلیکیشن و سایت عالیس را چگونه ارزیابی می کنید'),
                      Question(
                          question_1: question_4,
                          hint: 'لطفا سوال چهارم را پاسخ دهید'),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.9,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'ثبت نظر',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'با تشکر از پاسخگویی شما مشتری گرامی',
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                    offset: Offset(2, 4),
                                    blurRadius: 4,
                                    color: Color.fromARGB(255, 165, 158, 158),
                                  )
                                ],
                                fontFamily: 'IransansDn',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Question extends StatelessWidget {
  const Question({
    Key? key,
    required this.question_1,
    required this.hint,
    this.keyboardType,
    this.showhide = false,
    // this.line,
  }) : super(key: key);

  final TextEditingController question_1;
  final String hint;
  final TextInputType? keyboardType;
  final bool? showhide;
  // final int? line;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 12, left: 12),
      child: TextFormField(
        keyboardType: keyboardType,
        // maxLines: line,

        controller: question_1,
        obscureText: showhide!,
        inputFormatters: const [],
        style: const TextStyle(
          fontFamily: 'IransansDn',
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: hint,
          // prefixIcon: const Icon(Icons.key_outlined),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;
  const Title({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, top: 15),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'IransansDn',
          fontSize: 12,
          color: Colors.black87,
        ),
      ),
    );
  }
}
