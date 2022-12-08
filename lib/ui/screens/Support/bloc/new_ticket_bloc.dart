import 'package:local_notification_flutter_project/ui/data/ClassInfo/New_Ticket_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/new_ticket_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'new_ticket_event.dart';
part 'new_ticket_state.dart';

class NewTicketBloc extends Bloc<NewTicketEvent, NewTicketState> {
  final INewTicketRepository newTicketRepository;
  NewTicketBloc({required this.newTicketRepository})
      : super(NewTicketInitial()) {
    on<NewTicketEvent>((event, emit) async {
      try {
        if (event is NewTicketStarted) {
          emit(NewTicketLoading());
          final ticket = await newTicketRepository.ticket();
          emit(NewTicketSuccess(ticket: ticket));
        }
      } catch (e) {
        emit(NewTicketError(AppException()));
      }
    });
  }
}
