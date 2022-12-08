import 'package:local_notification_flutter_project/ui/data/ClassInfo/BankAccount_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/bank_account_data_source.dart';

final bankAccountRepository =
    BankAccountRepository(BankAccountRemoteDataSource(httpClient));

abstract class IBankAccountRepository {
  Future<List<BankAccountInfo>> bankaccount(
    String namebank,
    String cardNumber,
    String expiryDate,
    String cardHolderName,
    String cvvCode,
  );
}

class BankAccountRepository implements IBankAccountRepository {
  final IBankAccountDataSource dataSource;

  BankAccountRepository(this.dataSource);
  @override
  Future<List<BankAccountInfo>> bankaccount(
    String namebank,
    String cardNumber,
    String expiryDate,
    String cardHolderName,
    String cvvCode,
  ) {
    return dataSource.bankaccount(
      namebank,
      cardNumber,
      expiryDate,
      cardHolderName,
      cvvCode,
    );
  }
}
