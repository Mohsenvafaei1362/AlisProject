import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/wallet_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final IWalletRepository walletRepository;
  WalletBloc({required this.walletRepository}) : super(WalletInitial()) {
    on<WalletEvent>((event, emit) async {
      try {
        if (event is WalletClickedButtonCharge) {
          emit(WalletLoading());
          final charge = await walletRepository.walletcharge(
            event.price,
            event.cardNumber,
            event.ccv,
            event.month,
            event.years,
            event.pass,
            event.saveCard,
          );
          emit(WalletSuccess());
        } else if (event is WalletClickedButtonDecharge) {
          emit(WalletLoading());
          final decharge = await walletRepository
            ..walletdecharge(event.price);
          emit(WalletSuccess());
        }
      } catch (e) {
        emit(WalletError(AppException()));
      }
    });
  }
}
