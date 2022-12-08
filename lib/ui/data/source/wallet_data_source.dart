import 'package:local_notification_flutter_project/ui/data/ClassInfo/transaction_list_info.dart';
import 'package:dio/dio.dart';

abstract class IWalletDataSource {
  Future<List<TransactionListInfo>> wallet();
  Future<List<TransactionListInfo>> walletcharge(
    String price,
    String cardNumber,
    String ccv,
    String month,
    String years,
    String pass,
    bool saveCard,
  );
  Future<List<TransactionListInfo>> walletdecharge(String price);
}

class WalletRemoteDataSource implements IWalletDataSource {
  final Dio httpClient;

  WalletRemoteDataSource(this.httpClient);
  @override
  Future<List<TransactionListInfo>> wallet() {
    // TODO: implement wallet
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionListInfo>> walletcharge(
    String price,
    String cardNumber,
    String ccv,
    String month,
    String years,
    String pass,
    bool saveCard,
  ) {
    // TODO: implement walletcharge
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionListInfo>> walletdecharge(String price) {
    // TODO: implement walletdecharge
    throw UnimplementedError();
  }
}
