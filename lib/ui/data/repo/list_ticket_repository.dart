import 'package:local_notification_flutter_project/ui/data/ClassInfo/list_ticket_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/list_ticket_data_source.dart';

final listTicketRepository =
    ListTicketRepository(ListTicketRemoteDataSource(httpClient));

abstract class IListTicketRepository {
  Future<List<ListTicketInfo>> listTicket();
}

class ListTicketRepository implements IListTicketRepository {
  final IListTicketDataSource dataSource;

  ListTicketRepository(this.dataSource);
  @override
  Future<List<ListTicketInfo>> listTicket() => dataSource.listTicket();
}
