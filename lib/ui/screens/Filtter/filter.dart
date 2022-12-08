import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'searchfilter.dart';
// import 'package:ranger_slider/main.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => FilterState();
}

class FilterState extends State<Filter> {
  RangeValues currentRangeValues = const RangeValues(40, 80);
  bool valuefirst = false;
  bool valuesecound = false;
  bool valuetree = false;
  bool valuefour = false;
  bool valuefive = false;
  bool valuesex = false;
  bool valueseven = false;
  bool valueeight = false;
  bool valuenine = false;
  bool valueT = false;
  bool isSwitched = false;
  bool isSwitched_1 = false;
  bool isSwitched_2 = false;

  @override
  void initState() {
    super.initState();
  }

  final UiSearching searching = Get.put(UiSearching());
  @override
  Widget build(BuildContext context) {
    RangeValues values = const RangeValues(1, 100);
    var size = MediaQuery.of(context).size;
    searching.valuefirst.value = valuefirst.toString();
    searching.valuesecound.value = valuesecound.toString();
    searching.valuetree.value = valuetree.toString();
    searching.valuefour.value = valuefour.toString();
    searching.valuefive.value = valuefive.toString();
    searching.valuesex.value = valuesex.toString();
    searching.valueseven.value = valueseven.toString();
    searching.valueeight.value = valueeight.toString();
    searching.valuenine.value = valuenine.toString();
    searching.isSwitched.value = isSwitched.toString();
    searching.isSwitched_1.value = isSwitched_1.toString();
    searching.isSwitched_2.value = isSwitched_2.toString();
    searching.valueT.value = valueT.toString();

    return Listener(
      onPointerDown: (event) {},
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: size.width * 0.9,
          child: FloatingActionButton.extended(
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Directionality(
                      textDirection: TextDirection.rtl, child: Serching2()),
                ),
              );
            },
            label: Text(
              'مشاهده جستجو'.toPersianDigit(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(bottom: 70),
              width: size.width,
              // height: size.height,
              // color: Colors.amber,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: size.width,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      // color: Colors.black.withOpacity(0.1),
                      border: Border(
                        bottom:
                            BorderSide(color: Colors.black.withOpacity(0.05)),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'فیلترها',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(
                              () {
                                valuefirst = false;
                                valuesecound = false;
                                valuetree = false;
                                valuefour = false;
                                valuefive = false;
                                valuesex = false;
                                valueseven = false;
                                valueeight = false;
                                valuenine = false;
                                valueT = false;
                                isSwitched = false;
                                isSwitched_1 = false;
                                isSwitched_2 = false;
                              },
                            );
                          },
                          child: const Text(
                            'حذف فیلترها',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  SizedBox(
                    // color: Colors.amber,
                    width: size.width,
                    child: ExpansionTile(
                      title: const Text(
                        'دسته بندی',
                        style: TextStyle(
                          fontFamily: 'IransansDn',
                          // fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    valuefirst = !valuefirst;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('شیر'),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                      value: valuefirst,
                                      onChanged: (value) {
                                        setState(() {
                                          valuefirst = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    valuesecound = !valuesecound;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('دوغ'),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                      value: valuesecound,
                                      onChanged: (value) {
                                        setState(() {
                                          valuesecound = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    valuetree = !valuetree;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('آبمیوه'),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                      value: valuetree,
                                      onChanged: (value) {
                                        setState(() {
                                          valuetree = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    valuefour = !valuefour;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('آبمیوه گازدار'),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                      value: valuefour,
                                      onChanged: (value) {
                                        setState(() {
                                          valuefour = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    valuefive = !valuefive;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('آبمیوه گازدار تشریفاتی'),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                      value: valuefive,
                                      onChanged: (value) {
                                        setState(() {
                                          valuefive = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    valuesex = !valuesex;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('شیر ساده'),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                      value: valuesex,
                                      onChanged: (value) {
                                        setState(() {
                                          valuesex = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    valueseven = !valueseven;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('شیر طعم دار'),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                      value: valueseven,
                                      onChanged: (value) {
                                        setState(() {
                                          valueseven = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    valueeight = !valueeight;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('آب معدنی'),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                      value: valueeight,
                                      onChanged: (value) {
                                        setState(() {
                                          valueeight = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    valuenine = !valuenine;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('ماءالشعیر'),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                      value: valuenine,
                                      onChanged: (value) {
                                        setState(() {
                                          valuenine = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    valueT = !valueT;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('نوشابه'),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                      value: valueT,
                                      onChanged: (value) {
                                        setState(() {
                                          valueT = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    child: ExpansionTile(
                      title: Row(
                        children: const [
                          Text(
                            'محدوده قیمت',
                            style: TextStyle(
                              fontFamily: 'IransansDn',
                              // fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // Text(
                          //   '${_currentRangeValues.start}'
                          //       .toString()
                          //       .toPersianDigit()
                          //       .seRagham(),
                          //   style: TextStyle(
                          //     fontFamily: 'IransansDn',
                          //     // fontWeight: FontWeight.bold,
                          //     fontSize: 12,
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // Text(
                          //   '${_currentRangeValues.end}'
                          //       .toString()
                          //       .toPersianDigit()
                          //       .seRagham(),
                          //   style: TextStyle(
                          //     fontFamily: 'IransansDn',
                          //     // fontWeight: FontWeight.bold,
                          //     fontSize: 12,
                          //   ),
                          // ),
                        ],
                      ),
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: RangeSlider(
                                      values: currentRangeValues,
                                      // inactiveColor: Colors.amber,
                                      max: 25000,
                                      divisions: 1000,
                                      labels: RangeLabels(
                                        currentRangeValues.start
                                            .round()
                                            .toString()
                                            .toPersianDigit()
                                            .seRagham(),
                                        currentRangeValues.end
                                            .round()
                                            .toString()
                                            .toPersianDigit()
                                            .seRagham(),
                                      ),
                                      onChanged: (RangeValues values) {
                                        setState(() {
                                          currentRangeValues = values;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(
                        () {
                          isSwitched = !isSwitched;
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('فقط کالاهای موجود'),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(
                                () {
                                  isSwitched = value;
                                },
                              );
                            },
                            // activeTrackColor: Colors.blue,
                            activeColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(
                        () {
                          isSwitched_1 = !isSwitched_1;
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('کالاهای تخفیف دار'),
                          Switch(
                            value: isSwitched_1,
                            onChanged: (value) {
                              setState(
                                () {
                                  isSwitched_1 = value;
                                },
                              );
                            },
                            // activeTrackColor: Colors.blue,
                            activeColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(
                        () {
                          isSwitched_2 = !isSwitched_2;
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('موجودی حساب'),
                          Switch(
                            value: isSwitched_2,
                            onChanged: (value) {
                              setState(
                                () {
                                  isSwitched_2 = value;
                                },
                              );
                            },
                            // activeTrackColor: Colors.blue,
                            activeColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
