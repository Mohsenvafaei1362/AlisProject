import 'package:local_notification_flutter_project/ui/data/repo/wallet_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/TransactionList/bloc/wallet_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    walletBloc?.close();
  }

  int? price;
  bool controlPrice = true;
  bool isSwitched = false;
  bool authCard = false;
  WalletBloc? walletBloc;
  String bankName = '';

  final TextEditingController priceController = TextEditingController();
  final TextEditingController cardController = TextEditingController();
  final TextEditingController ccv = TextEditingController();
  final TextEditingController month = TextEditingController();
  final TextEditingController years = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController saveCard = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: size.width * 0.9,
        height: size.height * 0.06,
        child: FloatingActionButton.extended(
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: const Color(0xfffafafa),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => FollowUp(),
            //   ),
            // );
          },
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  showMaterialModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    context: context,
                    builder: (context) {
                      return Container(
                        width: size.width,
                        height: size.height * 0.6,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              width: size.width,
                              height: size.height * 0.07,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text(
                                      'شارژ کیف پول',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: size.width * 0.9,
                              height: size.height * 0.06,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                readOnly: true,
                                enabled: controlPrice,
                                controller: priceController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    fontFamily: 'IransansDn',
                                    fontSize: 14,
                                    color: Colors.black45),
                                obscureText: false,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  suffix: priceController.text.isNotEmpty
                                      ? const Text('تومان')
                                      : const Text(''),
                                  // suffixIcon:
                                  //     const Icon(CupertinoIcons.creditcard_fill),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  // labelText: 'مبلغ دلخواه',
                                  //
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 22, top: 10),
                                  child: Text(
                                    'شماره کارت',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 22, top: 10),
                                  child: Text(
                                    bankName,
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: size.width * 0.9,
                              height: size.height * 0.08,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CardNumberFormatter(),
                                  LengthLimitingTextInputFormatter(19)
                                ],
                                textAlign: TextAlign.end,
                                enabled: controlPrice,
                                controller: cardController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  fontFamily: 'IransansDn',
                                  fontSize: 14,
                                  color: Colors.black45,
                                ),
                                obscureText: false,
                                onChanged: (value) {
                                  setState(() {
                                    bankName = value
                                        .replaceAll('-', "")
                                        .getBankNameFromCardNumber();
                                    authCard = value
                                        .replaceAll('-', "")
                                        .isValidBankCardNumber();
                                  });
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                      CupertinoIcons.creditcard_fill),
                                  // suffixIcon:
                                  //     const Icon(CupertinoIcons.creditcard_fill),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Box(
                                    size: size,
                                    title: 'ccv2',
                                    borderRadius: BorderRadius.circular(10),
                                    lengthLimitingTextInputFormatter:
                                        LengthLimitingTextInputFormatter(8),
                                    lable: 'ccv2',
                                    textEditingController: ccv,
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  Box(
                                    size: size,
                                    title: 'تاریخ انقضا',
                                    borderRadius: BorderRadius.circular(10),
                                    lengthLimitingTextInputFormatter:
                                        LengthLimitingTextInputFormatter(2),
                                    lable: 'ماه',
                                    textEditingController: month,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Box(
                                    size: size,
                                    title: '',
                                    borderRadius: BorderRadius.circular(10),
                                    lengthLimitingTextInputFormatter:
                                        LengthLimitingTextInputFormatter(2),
                                    lable: 'سال',
                                    textEditingController: years,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text(
                                        'رمز دوم / پویا',
                                        style: TextStyle(fontSize: 10),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: size.width * 0.9,
                                  height: size.height * 0.06,
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(top: 10),
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: size.width * 0.3,
                                          height: size.height,
                                          // color: Colors.red,
                                          child: TextFormField(
                                            controller: pass,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  21)
                                            ],
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              // labelText: 'رمز دوم',
                                              // label: Text('رمز دوم'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: (() {}),
                                        child: const Text('دریافت رمز پویا'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: StatefulBuilder(
                                    builder: (BuildContext context, setState) =>
                                        Switch(
                                      onChanged: (bool v) {
                                        setState(() => isSwitched = v);
                                      },
                                      value: isSwitched,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'ذخیره شماره کارت',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: size.width * 0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  authCard == false
                                      ? ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          const SnackBar(
                                            duration: Duration(seconds: 2),
                                            content:
                                                Text("شماره کارت نا معتبر است"),
                                          ),
                                        )
                                      //  Get.snackbar(
                                      //     "شماره کارت نا معتبر است",
                                      //     "",
                                      //     snackPosition: SnackPosition.BOTTOM,
                                      //     duration: const Duration(
                                      //         milliseconds: 3000),
                                      //   )
                                      : walletBloc?.add(
                                          WalletClickedButtonCharge(
                                            price: priceController.text,
                                            cardNumber: cardController.text,
                                            ccv: ccv.text,
                                            years: years.text,
                                            month: month.text,
                                            pass: pass.text,
                                            saveCard: isSwitched,
                                          ),
                                        );
                                },
                                child: const Text(
                                  'تایید',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Center(
                  child: Container(
                    width: size.width * 0.9,
                    height: size.height * 0.06,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        'شارژ حساب',
                        style: TextStyle(fontFamily: 'IransansDn'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocProvider<WalletBloc>(
        create: (context) {
          final bloc = WalletBloc(walletRepository: walletRepository);
          walletBloc = bloc;
          bloc.add(WalletStarted());
          return bloc;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.keyboard_arrow_right)),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text('حساب'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        width: size.width,
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icons/wallet.png',
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('موجودی حساب'),
                                  Row(
                                    children: [
                                      const Text('0'),
                                      Image.asset(
                                        'assets/icons/tom.png',
                                        width: 24,
                                        height: 24,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  // BlocProvider.of<WalletBloc>(context).add(WalletClickedButtonDecharge(price))
                                },
                                child: Container(
                                  height: 35,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.lightBlueAccent,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'برداشت از حساب',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'شارژ  حساب',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'مبلغ مورد نیاز خود را وارد نمایید یا از میان مبالغ پیشنهادی یک گزینه را انتخاب فرمایید',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(children: const [
                        Icon(
                          Icons.history,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'تاریخچه تراکنش ها',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            // color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            inputFormatters: [],
                            enabled: controlPrice,
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontFamily: 'IransansDn',
                                fontSize: 10,
                                color: Colors.black45),
                            obscureText: false,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              suffix: priceController.text.isNotEmpty
                                  ? const Text('تومان')
                                  : Text(''),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              labelText: 'مبلغ دلخواه',
                              //
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: size.width / 4,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: TextButton(
                                onPressed: (() {
                                  setState(() {
                                    priceController.text = int.parse('50000')
                                        .toString()
                                        .toPersianDigit()
                                        .seRagham();
                                  });
                                }),
                                child: Text(
                                  '50,000 تومان'.toPersianDigit(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width / 4,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextButton(
                              onPressed: (() {
                                setState(() {
                                  priceController.text = int.parse('100000')
                                      .toString()
                                      .toPersianDigit()
                                      .seRagham();
                                });
                              }),
                              child: Text(
                                '100,000 تومان'.toPersianDigit(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            width: size.width / 4,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextButton(
                              onPressed: (() {
                                setState(() {
                                  priceController.text = int.parse('200000')
                                      .toString()
                                      .toPersianDigit()
                                      .seRagham();
                                });
                              }),
                              child: Text(
                                '200,000 تومان'.toPersianDigit(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 40,
                          ),
                          child: priceController.text.isNotEmpty
                              ? Text(
                                  ' مبلغ افزایش موجودی ${priceController.text} تومان'
                                      .toPersianDigit(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45),
                                )
                              : const Text(''),
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

class Box extends StatelessWidget {
  const Box({
    Key? key,
    required this.size,
    required this.title,
    required this.borderRadius,
    required this.lengthLimitingTextInputFormatter,
    required this.lable,
    required this.textEditingController,
  }) : super(key: key);

  final Size size;
  final String title, lable;
  final BorderRadius borderRadius;
  final LengthLimitingTextInputFormatter lengthLimitingTextInputFormatter;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: size.width * 0.25,
          height: size.height * 0.05,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
          ),
          child: TextFormField(
            controller: textEditingController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              lengthLimitingTextInputFormatter,
            ],
            decoration: InputDecoration(
              label: Center(child: Text(lable)),
            ),
          ),
        ),
      ],
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write('-');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
