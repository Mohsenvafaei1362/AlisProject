import 'package:flutter/services.dart';

class MessageBoxInfo {
  final String title;
  final String description;
  final DateTime date;

  MessageBoxInfo(
    this.title,
    this.description,
    this.date,
  );

  MessageBoxInfo.fromJson(Map json)
      : title = json['title'],
        description = json['description'],
        date = json['data'];
}

class MessageCount {
  // final int OnReadCount;
  final int ID;
  final int UserRef;
  final String Title;
  final String Desc;
  final String PersianDate;
  final String Time;
  // List<int> Avatar = [];
  final String Avatar;
  final String Link;
  final bool IsRead;
  bool isActive = true;

  MessageCount(
    // this.OnReadCount,
    this.ID,
    this.UserRef,
    this.Title,
    this.Desc,
    this.PersianDate,
    this.Time,
    this.Avatar,
    this.Link,
    this.IsRead,
  );
  MessageCount.fromJson(Map json)
      : ID = json['id'],
        UserRef = json['userRef'],
        Title = json['title'],
        Desc = json['desc'],
        PersianDate = json['persianDate'],
        Time = json['time'],
        Avatar = json['avatar'],
        Link = json['link'],
        IsRead = json['isRead'];
  // OnReadCount = json['onReadCount'];
}
