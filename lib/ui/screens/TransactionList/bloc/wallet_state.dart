part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();
  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletSuccess extends WalletState {}

class WalletLoading extends WalletState {}

class WalletError extends WalletState {
  final AppException exception;

  const WalletError(this.exception);
  @override
  List<Object?> get props => [exception];
}
