import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_notification_flutter_project/ui/screens/CommentSuggest/commentsuggest.dart';

class Comment_Product extends StatefulWidget {
  bool isChecked = false;

  @override
  State<Comment_Product> createState() => _Comment_ProductState();
}

class _Comment_ProductState extends State<Comment_Product> {
  bool isChecked = false;

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color.fromARGB(255, 255, 197, 110),
        //   toolbarHeight: 20,
        // ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_right_rounded,
                        ),
                      ),
                      const Text(
                        'نظر سنجی',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('دیدگاه خود را شرح دهید'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Question(
                      question_1: question_1,
                      hint: 'عنوان نظر',
                    ),
                    Question(
                      question_1: question_2,
                      hint: 'نقاط قوت',
                    ),
                    Question(
                      question_1: question_3,
                      hint: 'نقاط ضعف',
                    ),
                    Question(
                      question_1: question_4,
                      hint: 'متن نظر',
                      keyboardType: TextInputType.multiline,
                      // line: 4,
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(12),
                    //     child: TextField(
                    //       textAlign: TextAlign.right,
                    //       keyboardType: TextInputType.multiline,
                    //       maxLines: 4,
                    //       decoration: InputDecoration(
                    //         border: InputBorder.none,
                    //         fillColor: Colors.grey.shade300,
                    //         filled: true,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                      ),
                      const Text(' ارسال دیدگاه به صورت ناشناس  '),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 25,
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 8, 0),
                          child: ClipRRect(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 50,
                                      child: TextButton(
                                        autofocus: false,
                                        onPressed: () {},
                                        child: Text(
                                          'ثبت دیدگاه ها',
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 33),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(4, 11, 7, 0),
                                child: RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 16),
                                      children: [
                                        const TextSpan(
                                            text:
                                                "ثبت دیدگاه به معنی موافقت با "),
                                        const TextSpan(
                                          text: "قوانین هلدینگ عالیس",
                                          style: TextStyle(
                                            color: Color(0xff00Acc1),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const TextSpan(text: " "),
                                        const TextSpan(text: "است"),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
