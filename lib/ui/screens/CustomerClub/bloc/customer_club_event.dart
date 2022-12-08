part of 'customer_club_bloc.dart';

abstract class CustomerClubEvent extends Equatable {
  const CustomerClubEvent();
  @override
  List<Object?> get props => [];
}

class CustomerClubStarted extends CustomerClubEvent {}

class CustomerClubClickedButtonTutorial extends CustomerClubEvent {}

class CustomerClubClickedButtonRace extends CustomerClubEvent {}

class CustomerClubClickedButtonloan extends CustomerClubEvent {}

class CustomerClubClickedButtonPackage extends CustomerClubEvent {}

class CustomerClubClickedButtonprogressPath extends CustomerClubEvent {}

class CustomerClubClickedButtonConvert extends CustomerClubEvent {}
