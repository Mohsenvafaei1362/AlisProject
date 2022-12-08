import 'package:http/http.dart' as http;
import 'dart:convert';

const String key = "service.903e38d33a464b099413963d9721501b";

class Ui_LocationHelper {
  static String Ui_LocationImage(double lat, double lon) {
    return "https://api.neshan.org/v2/static?key=$key&type=neshan&zoom=15&center=$lat,$lon&width=500&height=500&marker=red";
  }

  static Future<String> Ui_GetAddress(double lat, double lon) async {
    var url = Uri.parse("https://api.neshan.org/v2/reverse?lat=$lat&lng=$lon");

    var result = await http.get(url, headers: {'Api-Key': key});
    return json.decode(result.body)["formatted_address"];
  }
}
