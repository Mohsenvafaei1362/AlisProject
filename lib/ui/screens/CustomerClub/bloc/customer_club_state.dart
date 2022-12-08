part of 'customer_club_bloc.dart';

abstract class CustomerClubState extends Equatable {
  const CustomerClubState();
  @override
  List<Object?> get props => [];
}

class CustomerClubInitial extends CustomerClubState {}

class CustomerClubSuccess extends CustomerClubState {
  final List<CustomerClubInfo> userInfo;
  final List<TopPepoleInfo> topPepole;

  const CustomerClubSuccess({required this.userInfo, required this.topPepole});
}

class CustomerClubLoading extends CustomerClubState {}

class CustomerClubError extends CustomerClubState {
  final AppException exception;

  const CustomerClubError(this.exception);
  @override
  List<Object?> get props => [exception];
}
