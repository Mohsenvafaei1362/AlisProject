import 'package:local_notification_flutter_project/ui/data/ClassInfo/transaction_list_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/transaction_list_data_source.dart';

final transactionListRepository =
    TransactionListRepository(TransactionListRemoteDataSource(httpClient));

abstract class ITransactionListRepository {
  Future<List<TransactionListInfo>> transaction();
}

class TransactionListRepository implements ITransactionListRepository {
  final ITransactionListDataSource dataSource;

  TransactionListRepository(this.dataSource);
  @override
  Future<List<TransactionListInfo>> transaction() => dataSource.transaction();
}
