import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/data/repo/CommentProduct_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/CommentSuggest/commentsuggest.dart';
import 'package:local_notification_flutter_project/ui/screens/Comment_Product/bloc/comment_product_bloc.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider<CommentProductBloc>(
            create: (context) {
              final bloc = CommentProductBloc(
                commentProductRepository: commentProductRepository,
              );
              bloc.add(CommentProductStarted());
              return bloc;
            },
            child: BlocBuilder<CommentProductBloc, CommentProductState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
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
                            '?????? ????????',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '???????????? ?????? ???? ?????? ????????',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Question(
                      question_1: question_1,
                      hint: '?????????? ??????',
                    ),
                    Question(
                      question_1: question_2,
                      hint: '???????? ??????',
                    ),
                    Question(
                      question_1: question_3,
                      hint: '???????? ??????',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: question_4,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // fillColor: Colors.grey.shade300,
                          filled: true,
                          labelText: '?????? ???????? ??????',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.9,
                          child: ElevatedButton(
                            onPressed: () {
                              if (question_1.text.length > 0 &&
                                  question_2.text.length > 0 &&
                                  question_3.text.length > 0 &&
                                  question_4.text.length > 0) {
                                // BlocProvider.of<CommentProductBloc>(context)
                                //     .add(
                                //   CommentProductClickdButton(
                                //     question_1.text,
                                //     question_2.text,
                                //     question_3.text,
                                //     question_4.text,
                                //   ),
                                // );
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('???????? ?????? ???? ???????????? ?????????? ????'),
                                  ),
                                );
                              } else {
                                Get.defaultDialog(
                                  title: '???????? ??????????',
                                  middleText: ' ???????? ?????????? ???????????? ???? ????????',
                                  middleTextStyle:
                                      TextStyle(color: Colors.pink[300]),
                                  onCancel: () {},
                                  textCancel: '?????????? ??????',
                                  titleStyle: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                            },
                            child: state is CommentProductLoading
                                ? CupertinoActivityIndicator()
                                : Text(
                                    '?????? ????????????',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     RichText(
                    //       text: TextSpan(
                    //         text: '?????? ???????????? ???? ???????? ???????????? ???? ',
                    //         style: const TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.black54,
                    //           fontSize: 16,
                    //         ),
                    //         children: const [
                    //           TextSpan(
                    //             text: "???????????? ???????????? ??????????",
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.blueAccent,
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
