import 'package:local_notification_flutter_project/ui/data/ClassInfo/customer_clubInfo.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/topPepole.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/customer_club_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/topPepole_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'customer_club_event.dart';
part 'customer_club_state.dart';

class CustomerClubBloc extends Bloc<CustomerClubEvent, CustomerClubState> {
  final ICustomerClubRepository customerClubRepository;
  final ITopPepoleRepository topPepoleRepository;
  CustomerClubBloc(
      {required this.customerClubRepository, required this.topPepoleRepository})
      : super(CustomerClubInitial()) {
    on<CustomerClubEvent>((event, emit) async {
      try {
        if (event is CustomerClubStarted) {
          emit(CustomerClubLoading());
          final customer = await customerClubRepository.getUserInfo();
          final topPepole = await topPepoleRepository.topPepole();
          emit(CustomerClubSuccess(userInfo: customer, topPepole: topPepole));
        }
      } catch (e) {
        emit(CustomerClubError(AppException()));
      }
    });
  }
}
