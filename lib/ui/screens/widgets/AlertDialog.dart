import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alert_Dialog {
  get alert => Get.defaultDialog(
        title: 'کابر گرامی',
        middleText: ' لطفا تمامی فیلدها پر شوند',
        middleTextStyle: TextStyle(color: Colors.pink[300]),
        onCancel: () {},
        textCancel: 'متوجه شدم',
        titleStyle: TextStyle(
          color: Colors.amber,
          fontWeight: FontWeight.bold,
        ),
      );
}
