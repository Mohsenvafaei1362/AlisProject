import 'package:local_notification_flutter_project/ui/data/ClassInfo/BankAccount_info.dart';
import 'package:dio/dio.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/ValidationResponse.dart';

abstract class IBankAccountDataSource {
  Future<List<BankAccountInfo>> bankaccount(
    String namebank,
    String cardNumber,
    String expiryDate,
    String cardHolderName,
    String cvvCode,
  );
}

class BankAccountRemoteDataSource implements IBankAccountDataSource {
  final Dio httpClient;

  BankAccountRemoteDataSource(this.httpClient);
  @override
  Future<List<BankAccountInfo>> bankaccount(
    String namebank,
    String cardNumber,
    String expiryDate,
    String cardHolderName,
    String cvvCode,
  ) async {
    final response = await httpClient.post(
      'path',
      data: {
        'namebank': namebank,
        'cardNumber': cardNumber,
        'expiryDate': expiryDate,
        'cardHolderName': cardHolderName,
        'cvvCode': cvvCode,
      },
    );
    // validateResponse(response);
    final List<BankAccountInfo> bankAccount = [];
    for (var element in (response.data as List)) {
      bankAccount.add(BankAccountInfo.fromJson(element));
    }
    return bankAccount;
  }
}
