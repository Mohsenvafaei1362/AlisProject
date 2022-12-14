part of 'test_bloc.dart';

abstract class TestState extends Equatable {
  const TestState();

  @override
  List<Object> get props => [];
}

class TestInitial extends TestState {}

class TestSuccess extends TestState {
  final List<TestUserInfo> test;

  TestSuccess(
    this.test,
  );
}

class TestLoading extends TestState {}

class TestError extends TestState {
  final AppException exception;

  TestError(this.exception);
}
