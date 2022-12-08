import 'package:local_notification_flutter_project/ui/data/repo/bank_account_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Setting/BankAccount/bloc/bank_account_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:flip_card/flip_card.dart';

class BankAccount extends StatefulWidget {
  @override
  State<BankAccount> createState() => _BankAccountState();
}

String cardNumber = '';
String cardBankName = '';
String cardDate = '';
String cardHolder = '';
String cardCvv = '';
Fill fill = Fill.fillBack;

final TextEditingController _cardNumber = TextEditingController();
final TextEditingController _holderCard = TextEditingController();
final TextEditingController _date = TextEditingController();
final TextEditingController _cvv = TextEditingController();

class _BankAccountState extends State<BankAccount> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocProvider<BankAccountBloc>(
        create: (context) {
          final bloc = BankAccountBloc(
            bankAccountRepository: bankAccountRepository,
          );
          bloc.add(BankAccountStarted());
          return bloc;
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: BlocBuilder<BankAccountBloc, BankAccountState>(
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        /*Add the title section to the app body*/
                        _buildTitleSection(
                          title: "حساب بانکی",
                          // subTitle: "",
                        ),
                        FlipCard(
                          fill:
                              fill, // Fill the back side of the card to make in the same size as the front.
                          direction: FlipDirection.HORIZONTAL, // default
                          front: _buildCreditCard(
                            color: const Color(0xFF090943),
                            cardExpiration: cardDate.isNotEmpty
                                ? cardDate.toPersianDigit()
                                : "08/01".toPersianDigit(),
                            cardHolder: cardHolder.isNotEmpty
                                ? cardHolder
                                : "----------",
                            cardNumber: cardNumber.isNotEmpty
                                ? cardNumber.toPersianDigit()
                                : "3546 7532 XXXX 9742".toPersianDigit(),
                          ),
                          back: Card(
                            elevation: 4.0,
                            color: const Color(0xFF090943),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Container(
                              height: 200,
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, bottom: 22.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  /* Here we are going to place the _buildLogosBlock */
                                  _buildLogosBlock(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    /* Here we are going to place the Card number */
                                    child: Column(
                                      children: [
                                        _buildDetailsBlock(
                                          label: 'CVV',
                                          value: cardCvv.isNotEmpty
                                              ? cardCvv.toPersianDigit()
                                              : 'xxxx',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          textDirection: TextDirection.rtl,
                          controller: _cardNumber,
                          onChanged: (value) {
                            setState(() {
                              cardNumber = value;
                            });
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            // Limit the input
                            LengthLimitingTextInputFormatter(16),
                            CardNumberInputFormatter(),
                          ],
                          decoration: const InputDecoration(
                            hintText: "شماره کارت",
                            hintTextDirection: TextDirection.rtl,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _holderCard,
                          onChanged: (value) {
                            setState(() {
                              cardHolder = value;
                            });
                          },
                          textDirection: TextDirection.rtl,
                          decoration: const InputDecoration(
                            hintText: "نام صاحب کارت",
                            hintTextDirection: TextDirection.rtl,
                          ),
                          // keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.47,
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    cardDate = value;
                                  });
                                },
                                controller: _date,
                                textDirection: TextDirection.rtl,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  // Limit the input
                                  LengthLimitingTextInputFormatter(4),
                                  CardMonthInputFormatter(),
                                ],
                                decoration: const InputDecoration(
                                  hintText: "ماه / سال",
                                  hintTextDirection: TextDirection.rtl,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.47,
                              child: TextFormField(
                                onChanged: (value) {
                                  fill = Fill.fillBack;
                                  setState(() {
                                    cardCvv = value;
                                  });
                                },
                                controller: _cvv,
                                textDirection: TextDirection.rtl,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  // Limit the input
                                  LengthLimitingTextInputFormatter(16),
                                  // CardNumberInputFormatter(),
                                ],
                                decoration: const InputDecoration(
                                  hintText: "CVV",
                                  hintTextDirection: TextDirection.rtl,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        _buildAddCardButton(
                            color: const Color(0xFF090943),
                            icon: const Icon(CupertinoIcons.add)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build the title section
  Column _buildTitleSection({required title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0),
          child: Text(
            '$title',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
        //   child: Text(
        //     '$subTitle',
        //     style: const TextStyle(fontSize: 21, color: Colors.black45),
        //   ),
        // )
      ],
    );
  }
}

Card _buildCreditCard({
  required Color color,
  required String cardNumber,
  required String cardHolder,
  required String cardExpiration,
}) {
  return Card(
    elevation: 4.0,
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    child: Container(
      height: 200,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /* Here we are going to place the _buildLogosBlock */
          _buildLogosBlock(),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            /* Here we are going to place the Card number */
            child: Text(
              cardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontFamily: 'CourrierPrime',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /* Here we are going to place the _buildDetailsBlock */
              _buildDetailsBlock(
                label: 'دارنده کارت',
                value: cardHolder,
              ),
              _buildDetailsBlock(
                label: 'تاریخ اعتبار',
                value: cardExpiration,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Row _buildLogosBlock() {
  return Row(
    /*1*/
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      const Icon(
        CupertinoIcons.wifi,
        color: Colors.white,
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        cardNumber.replaceAll(' ', '').getBankNameFromCardNumber() == '-'
            ? ''
            : cardNumber.replaceAll(' ', '').getBankNameFromCardNumber(),
        style: const TextStyle(color: Colors.white),
      ),
      const Spacer(),
      ClipOval(
        child: Image.asset(
          "assets/images/10.jpg",
          height: 30,
          width: 30,
        ),
      ),
    ],
  );
}

Column _buildDetailsBlock({required String label, required String value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
            color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
      ),
      Text(
        value,
        style: const TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      )
    ],
  );
}

Container _buildAddCardButton({
  required Icon icon,
  required Color color,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 24.0),
    alignment: Alignment.center,
    child: FloatingActionButton(
      elevation: 2.0,
      onPressed: () {
        print("Add a credit card");
      },
      backgroundColor: color,
      mini: false,
      child: icon,
    ),
  );
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
