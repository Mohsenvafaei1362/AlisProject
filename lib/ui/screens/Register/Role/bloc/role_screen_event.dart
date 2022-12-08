part of 'role_screen_bloc.dart';

abstract class RoleScreenEvent extends Equatable {
  const RoleScreenEvent();
  @override
  List<Object> get props => [];
}

class RoleScreenStarted extends RoleScreenEvent {}

class RoleScreenClickButton extends RoleScreenEvent {
  // final String Role;
  final Ui_UserUpdateDto userUpdateDto;

  const RoleScreenClickButton(
    this.userUpdateDto,
  );
}

class RolScreenGetInfoUser extends RoleScreenEvent {
  final String FName;
  final String LName;
  final String Email;
  final int NationalCode;
  final int EparchyRef;
  final int CityRef;
  final int PostalCode;
  final String CityName;
  final String EparchyName;

  RolScreenGetInfoUser(
      this.FName,
      this.LName,
      this.Email,
      this.NationalCode,
      this.EparchyRef,
      this.CityRef,
      this.PostalCode,
      this.CityName,
      this.EparchyName);
}
