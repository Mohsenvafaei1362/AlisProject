import 'package:local_notification_flutter_project/ui/data/ClassInfo/list_ticket_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/list_ticket_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_tickets_event.dart';
part 'list_tickets_state.dart';

class ListTicketsBloc extends Bloc<ListTicketsEvent, ListTicketsState> {
  final IListTicketRepository listTicketRepository;
  ListTicketsBloc({required this.listTicketRepository})
      : super(ListTicketsInitial()) {
    on<ListTicketsEvent>((event, emit) async {
      try {
        if (event is ListTicketsStarted) {
          emit(ListTicketsLoading());
          final listTicket = await listTicketRepository.listTicket();
          emit(ListTicketsSuccess(listTicket: listTicket));
        }
      } catch (e) {
        emit(ListTicketsError(AppException()));
      }
    });
  }
}
