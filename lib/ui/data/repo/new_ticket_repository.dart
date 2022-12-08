import 'package:local_notification_flutter_project/ui/data/ClassInfo/New_Ticket_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/new_ticket_data_source.dart';

final newTicketRepository =
    NewTicketRepository(NewTicketRemoteDataSource(httpClient));

abstract class INewTicketRepository {
  Future<List<NewTicketInfo>> ticket();
}

class NewTicketRepository implements INewTicketRepository {
  final INewTicketDataSource dataSource;

  NewTicketRepository(this.dataSource);
  @override
  Future<List<NewTicketInfo>> ticket() => dataSource.ticket();
}
