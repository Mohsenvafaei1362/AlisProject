import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Repeate extends StatefulWidget {
  const Repeate({Key? key}) : super(key: key);

  @override
  State<Repeate> createState() => _RepeateState();
}

class _RepeateState extends State<Repeate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var bool = false;
    return Listener(
      onPointerDown: (event) {},
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.keyboard_arrow_right),
                    ),
                    Text('سوالات پر تکرار'),
                    Icon(Icons.question_mark_rounded),
                  ],
                ),
              ),
              Container(
                width: size.width,
                height: size.height,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 36),
                  child: ListView(
                    children: [
                      ExpansionTile(
                        title: Text(
                          'چگونه می توانم یک پروفایل ایجاد کنم ؟',
                          style: TextStyle(
                            fontFamily: 'IransansDn',
                            // fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        'در وب سایت روی گزینه "ثبت نام" کلیک کنید. میتوانید با استفاده از شماره موبایل ثبت نام خود را انجام دهید. (کد فعال سازی برایتان پیامک میشود .) بعد از وارد نمودن کد فعالسازی ، ثبت نام انجام می شود. سپس روی گزینه تکمیل اطلاعات کلیک و اطلاعات خود را تکمیل نمایید',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'IransansDn',
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'چگونه در اپلیکیشن عالیس سوالات خود را ثبت کنم ؟',
                          style: TextStyle(
                            fontFamily: 'IransansDn',
                            // fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        'بعد از ورود به پروفایل ، کالای مدنظر خود را به سبد خرید اضافه کنید ، پس از انتخاب آدرس میتوانید نوع پرداخت خود را انتخاب کنید.بعد از اتمام ثبت سفارش ، سیستم کد سفارش شما را نمایش خواهد داد. ',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontFamily: 'IransansDn',
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'کالایی را که در طرح شگفت انگیز عالیس می باشد می باشد می توان بیش از یک عدد خرید ',
                          style: TextStyle(
                            fontFamily: 'IransansDn',
                            fontSize: 12,
                          ),
                        ),
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      ' به دلیل اینکه طرح پیشنهاد شگفت انگیز عالیس یک طرح تشویقی خرید است عالیس تعهدی در قبال سفارش های تعددی ندارد و در صورتی که امکان فروش بیش از یک  عدد وجود داشته باشد هماهنگی های لازم با مشتری انجام خواهد شد',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontFamily: 'IransansDn',
                                        fontSize: 12,
                                      ),
                                    ),
                                  )),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'آیا امکان خرید در اپلیکیشن عالیس وجود دارد ',
                          style: TextStyle(
                            fontFamily: 'IransansDn',
                            fontSize: 12,
                          ),
                        ),
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      'برای خرید ابتدا سفارش خود را ثبت کنید در مرحله بعد به صفحه درگاه پرداخت منصل می شوید ومی توانید خرید خود را انجام دهید',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontFamily: 'IransansDn',
                                        fontSize: 12,
                                      ),
                                    ),
                                  )),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'منظور از کد معرف چیست',
                          style: TextStyle(
                            fontFamily: "IransansDn",
                            fontSize: 12,
                          ),
                        ),
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      'کد معرف همان کدی است که فردی که شما را با مجموعه آشنا کرده است در اختیار شما قرار می دهد برای آشنایی بیشتر با این موضوع به صفحه ی کد معرف مراجعه کنید',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontFamily: 'IransansDn',
                                        fontSize: 12,
                                      ),
                                    ),
                                  )),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'برای شرکت در قرعه کشی های عالیس چه باید کرد',
                          style: TextStyle(
                            fontFamily: 'IransansDn',
                            fontSize: 12,
                          ),
                        ),
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'کد معرف همان کدی است که فردی که شما را با مجموعه آشنا کرده است در اختیار شما قرار می دهد برای آشنایی بیشتر با این موضوع به صفحه ی کد معرف مراجعه کنید',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'IransansDn',
                                    fontSize: 12,
                                  ),
                                ),
                              ))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
