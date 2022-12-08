part of 'new_store_bloc.dart';

abstract class NewStoreEvent extends Equatable {
  const NewStoreEvent();
  @override
  List<Object?> get props => [];
}

class NewStoreStarted extends NewStoreEvent {}

class NewStoreClickedButton extends NewStoreEvent {
  final String name;
  final String address;
  final String image;
  final String branchtype;
  final int phoneNumber;
  final bool isactive;

  const NewStoreClickedButton({
    required this.name,
    required this.address,
    required this.image,
    required this.branchtype,
    required this.phoneNumber,
    required this.isactive,
  });
}
