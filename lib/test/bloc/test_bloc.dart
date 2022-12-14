import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/TestUser.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/test_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Test_repository.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final ITestRepository testRepository;
  TestBloc({required this.testRepository}) : super(TestLoading()) {
    on<TestEvent>((event, emit) async {
      try {
        // if (state is TestStarted) {
        emit(TestLoading());
        final response = await testRepository.test();
        // emit(TestSuccess(response));
        final user = await testRepository.user(response);
        emit(TestSuccess(user));
        // }
      } catch (e) {
        emit(TestError(AppException()));
      }
    });
  }
}
