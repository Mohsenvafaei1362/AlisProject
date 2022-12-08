import 'package:local_notification_flutter_project/ui/data/ClassInfo/New_Ticket_info.dart';
import 'package:dio/dio.dart';

abstract class INewTicketDataSource {
  Future<List<NewTicketInfo>> ticket();
}

class NewTicketRemoteDataSource implements INewTicketDataSource {
  final Dio httpClient;

  NewTicketRemoteDataSource(this.httpClient);
  @override
  Future<List<NewTicketInfo>> ticket() async {
    final response = await httpClient.get('path');
    final List<NewTicketInfo> ticket = [];
    for (var element in (response.data as List)) {
      ticket.add(NewTicketInfo.fromJson(element));
    }
    return ticket;
  }
}
