import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/message_box_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/message_box_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

final UiDl _dl = Get.put(UiDl());

abstract class IMessageBoxDataSource {
  Future<List<MessageBoxInfo>> message();
}

class MessageBoxRemoteDataSource implements IMessageBoxDataSource {
  final Dio httpClient;

  MessageBoxRemoteDataSource(this.httpClient);
  @override
  Future<List<MessageBoxInfo>> message() async {
    final response = await httpClient.get('path');
    final List<MessageBoxInfo> message = [];
    for (var element in (response.data as List)) {
      message.add(MessageBoxInfo.fromJson(element));
    }
    return message;
  }
}

abstract class IMessageCountDataSource {
  Future<List<MessageCount>> messageCount();
}

class MessageCountRemoteDataSource implements IMessageCountDataSource {
  final Dio httpClient;

  MessageCountRemoteDataSource(this.httpClient);
  @override
  Future<List<MessageCount>> messageCount() async {
    final response = await httpClient.get(
      'Message',
      queryParameters: {
        "UserRef": _dl.UserId,
        "IsRead": false,
      },
    );
    if (response.statusCode != 200) {
      throw AppException();
    } else {
      final List<MessageCount> messageCount = [];
      for (var element in (response.data as List)) {
        messageCount.add(MessageCount.fromJson(element));
      }
      return messageCount;
    }
  }
}
