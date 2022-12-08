import 'dart:io';

import 'package:local_notification_flutter_project/ui/screens/Register/Map/DB/boxes.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/DB/db_helper.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/helper/location_helper.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/models/point_location_model.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/models/point_model.dart';
import 'package:flutter/foundation.dart';
// import 'package:point_app/DB/boxes.dart';
// import 'package:point_app/DB/db_helper.dart';
// import 'package:point_app/helper/location_helper.dart';
// import 'package:point_app/models/point_location_model.dart';
// import 'package:point_app/models/point_model.dart';

class Ui_PointProvider with ChangeNotifier {
  List<Ui_PointModel> _points = [];

  List<Ui_PointModel> get getPoints => [..._points];

  Ui_PointModel getById(String id) {
    return _points.singleWhere((data) => data.id == id);
  }

  Future<void> addPoint(
      String title, File image, Ui_PointLocationModel location) async {
    var box = await Ui_Boxes.getPointsBox();
    String id = DateTime.now().toString();
    var address =
        await Ui_LocationHelper.Ui_GetAddress(location.lat, location.lon);
    var _resultLocation = Ui_PointLocationModel(
        lat: location.lat, lon: location.lon, address: address);
    final point = Ui_PointModel(
      id: id,
      title: title,
      location: _resultLocation,
      image: image,
    );

    _points.add(point);

    notifyListeners();

    Ui_DbHelper.addPoints(box, {
      'id': id,
      'title': title,
      'image': image.path,
      'lat': _resultLocation.lat,
      'lon': _resultLocation.lon,
      'address': _resultLocation.address
    });
  }

  Future<void> getData() async {
    var box = await Ui_Boxes.getPointsBox();
    _points = Ui_DbHelper.getPoints(box);
    notifyListeners();
  }

  Future<void> DeleteById(String id) async {
    var box = await Ui_Boxes.getPointsBox();
    box.toMap().forEach((key, value) {
      if (value['id'] == id) {
        box.delete(key);
      }
    });
  }
}
