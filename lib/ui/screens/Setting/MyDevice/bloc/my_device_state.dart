part of 'my_device_bloc.dart';

abstract class MyDeviceState extends Equatable {
  const MyDeviceState();
  @override
  List<Object?> get props => [];
}

class MyDeviceInitial extends MyDeviceState {}

class MyDeviceSuccess extends MyDeviceState {
  final List<MyDeviceInfo> mydevice;

  const MyDeviceSuccess(this.mydevice);
}

class MyDeviceLoading extends MyDeviceState {}

class MyDeviceError extends MyDeviceState {
  final AppException exception;

  const MyDeviceError(this.exception);
  @override
  List<Object?> get props => [exception];
}
