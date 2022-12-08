import 'package:local_notification_flutter_project/ui/data/ClassInfo/BankAccount_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/bank_account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bank_account_event.dart';
part 'bank_account_state.dart';

class BankAccountBloc extends Bloc<BankAccountEvent, BankAccountState> {
  final IBankAccountRepository bankAccountRepository;
  BankAccountBloc({required this.bankAccountRepository})
      : super(BankAccountInitial()) {
    on<BankAccountEvent>((event, emit) async {
      try {
        if (event is BankAccountClickedButton) {
          emit(BankAccountLoading());
          final bankAccount = await bankAccountRepository.bankaccount(
            event.nameBank,
            event.cardnumber,
            event.expiryDate.toString(),
            event.cardHolderName,
            event.cvvCode,
          );
          emit(BankAccountSuccess(bankAccount));
        }
      } catch (e) {
        emit(BankAccountError(AppException()));
      }
    });
  }
}
