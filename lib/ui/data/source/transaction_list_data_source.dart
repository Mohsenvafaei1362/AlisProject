import 'package:local_notification_flutter_project/ui/data/ClassInfo/transaction_list_info.dart';
import 'package:dio/dio.dart';

abstract class ITransactionListDataSource {
  Future<List<TransactionListInfo>> transaction();
}

class TransactionListRemoteDataSource implements ITransactionListDataSource {
  final Dio httpClient;

  TransactionListRemoteDataSource(this.httpClient);
  @override
  Future<List<TransactionListInfo>> transaction() async {
    final response = await httpClient.get('path');
    final List<TransactionListInfo> transaction = [];
    (response.data as List).forEach((element) {
      transaction.add(TransactionListInfo.fromJson(element));
    });
    return transaction;
  }
}
