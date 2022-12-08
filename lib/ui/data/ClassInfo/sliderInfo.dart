import 'package:flutter/foundation.dart';

class SliderInfo {
  final String link;
  final String img;
  SliderInfo(
    this.link,
    this.img,
  );

  SliderInfo.fromJson(Map json)
      : link = json['link'],
        img = json['img'];
}
