import 'package:local_notification_flutter_project/ui/data/ClassInfo/transaction_list_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/transaction_list_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'transaction_list_event.dart';
part 'transaction_list_state.dart';

class TransactionListBloc
    extends Bloc<TransactionListEvent, TransactionListState> {
  final ITransactionListRepository transactionListRepository;
  TransactionListBloc({required this.transactionListRepository})
      : super(TransactionListInitial()) {
    on<TransactionListEvent>((event, emit) async {
      try {
        if (state is TransactionListStarted) {
          emit(TransactionListLoading());
          final transaction = await transactionListRepository.transaction();
          emit(TransactionListSuccess(transaction));
        }
      } catch (e) {
        emit(TransactionListError(AppException()));
      }
    });
  }
}
