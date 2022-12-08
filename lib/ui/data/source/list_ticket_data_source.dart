import 'package:local_notification_flutter_project/ui/data/ClassInfo/list_ticket_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:dio/dio.dart';

abstract class IListTicketDataSource {
  Future<List<ListTicketInfo>> listTicket();
}

class ListTicketRemoteDataSource implements IListTicketDataSource {
  final Dio hhtpClient;

  ListTicketRemoteDataSource(this.hhtpClient);
  @override
  Future<List<ListTicketInfo>> listTicket() async {
    final response = await httpClient.get('path');
    final List<ListTicketInfo> listTicket = [];
    for (var element in (response.data as List)) {
      listTicket.add(ListTicketInfo.fromJson(element));
    }
    return listTicket;
  }
}
