import 'package:local_notification_flutter_project/ui/data/ClassInfo/transaction_list_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/wallet_data_source.dart';

final walletRepository = WalletRepository(WalletRemoteDataSource(httpClient));

abstract class IWalletRepository {
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

class WalletRepository implements IWalletRepository {
  final IWalletDataSource dataSource;

  WalletRepository(this.dataSource);
  @override
  Future<List<TransactionListInfo>> wallet() => dataSource.wallet();

  @override
  Future<List<TransactionListInfo>> walletcharge(
    String price,
    String cardNumber,
    String ccv,
    String month,
    String years,
    String pass,
    bool saveCard,
  ) =>
      dataSource.walletcharge(
        price,
        cardNumber,
        ccv,
        month,
        years,
        pass,
        saveCard,
      );

  @override
  Future<List<TransactionListInfo>> walletdecharge(String price) =>
      dataSource.walletdecharge(price);
}
