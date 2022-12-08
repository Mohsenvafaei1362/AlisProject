part of 'add_point_screen_bloc.dart';

abstract class AddPointScreenEvent extends Equatable {
  const AddPointScreenEvent();
  @override
  List<Object?> get props => [];
}

class AddPointScreenStarted extends AddPointScreenEvent {}

class AddPointScreenClickedButton extends AddPointScreenEvent {
  final String title;
  final double lat;
  final double long;
  final String image;
  final int RegisterLevelRef;
  final String RegisterLevelCode;
  final String RegisterLvelTitle;

  const AddPointScreenClickedButton({
    required this.title,
    required this.lat,
    required this.long,
    required this.image,
    required this.RegisterLevelRef,
    required this.RegisterLevelCode,
    required this.RegisterLvelTitle,
  });
}
