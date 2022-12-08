import 'package:hive/hive.dart';

class Ui_Boxes {
  static Future<Box> getPointsBox() async {
    if (!Hive.isBoxOpen("points")) {
      await Hive.openBox("points");
      return Hive.box("points");
    }
    return Hive.box("points");
  }
}
