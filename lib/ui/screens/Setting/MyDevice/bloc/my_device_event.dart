part of 'my_device_bloc.dart';

abstract class MyDeviceEvent extends Equatable {
  const MyDeviceEvent();
  @override
  List<Object?> get props => [];
}

class MyDeviceStarted extends MyDeviceEvent {}
