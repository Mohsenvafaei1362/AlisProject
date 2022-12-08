import 'package:local_notification_flutter_project/ui/data/ClassInfo/message_box_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/message_box_data_source.dart';

final messageBoxRepository =
    MessageBoxRepository(MessageBoxRemoteDataSource(httpClient));

final messageCountRepository =
    MessageCountRepository(MessageCountRemoteDataSource(httpClient));

abstract class IMessageBoxRepository {
  Future<List<MessageBoxInfo>> message();
}

class MessageBoxRepository implements IMessageBoxRepository {
  final IMessageBoxDataSource dataSource;

  MessageBoxRepository(this.dataSource);
  @override
  Future<List<MessageBoxInfo>> message() => dataSource.message();
}

abstract class IMessageCountRepository {
  Future<List<MessageCount>> messageCount();
}

class MessageCountRepository implements IMessageCountRepository {
  final IMessageCountDataSource dataSource;

  MessageCountRepository(this.dataSource);
  @override
  Future<List<MessageCount>> messageCount() => dataSource.messageCount();
}
