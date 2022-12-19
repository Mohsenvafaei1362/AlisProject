part of 'edit_info_user_bloc.dart';

abstract class EditInfoUserEvent extends Equatable {
  const EditInfoUserEvent();

  @override
  List<Object> get props => [];
}

class EditInfoUserClickedButton extends EditInfoUserEvent {
  final String fname;
  final String lname;
  final String email;
  final String phone;

  EditInfoUserClickedButton(
    this.fname,
    this.lname,
    this.email,
    this.phone,
  );
}
