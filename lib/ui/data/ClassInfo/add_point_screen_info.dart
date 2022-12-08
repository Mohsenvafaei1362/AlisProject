import 'dart:io';

class AddPointScreenInfo {
  final String title;
  final double lat;
  final double long;
  final String image;

  AddPointScreenInfo.fromJson(Map json)
      : title = json['title'],
        lat = json['lat'],
        long = json['long'],
        image = json['image'];
}
