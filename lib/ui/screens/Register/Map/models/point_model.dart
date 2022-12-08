import 'dart:io';

import 'package:local_notification_flutter_project/ui/screens/Register/Map/models/point_location_model.dart';
// import 'package:point_app/models/point_location_model.dart';

class Ui_PointModel {
  final String id;

  final String title;

  final Ui_PointLocationModel location;

  final File image;

  Ui_PointModel({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}
