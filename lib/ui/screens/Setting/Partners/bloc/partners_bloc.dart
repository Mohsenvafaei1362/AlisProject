import 'package:local_notification_flutter_project/ui/data/ClassInfo/Partners_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/partners_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'partners_event.dart';
part 'partners_state.dart';

class PartnersBloc extends Bloc<PartnersEvent, PartnersState> {
  final IPartnersRepository partnersRepository;
  PartnersBloc({required this.partnersRepository}) : super(PartnersInitial()) {
    on<PartnersEvent>((event, emit) async {
      try {
        if (event is PartnersStarted) {
          emit(PartnersLoading());
          final partners = await partnersRepository.partners();
          emit(PartnersSuccess(partners));
        }
      } catch (e) {
        emit(PartnersError(AppException()));
      }
    });
  }
}
