import 'dart:io';

import 'package:local_notification_flutter_project/ui/screens/Register/Map/models/point_location_model.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/models/point_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Ui_DbHelper {
  static void addPoints(Box box, dynamic data) {
    box.put(DateTime.now().toString(), data);
  }

  static List<Ui_PointModel> getPoints(Box box) {
    List<Ui_PointModel> _points = [];
    box.toMap().forEach((key, value) {
      _points.add(Ui_PointModel(
          id: value['id'],
          title: value['title'],
          location: Ui_PointLocationModel(
              lat: value['lat'], lon: value['lon'], address: value['address']),
          image: File(
            value['image'],
          )));
    });

    return _points;
  }
}
