import 'package:local_notification_flutter_project/ui/data/ClassInfo/auto_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/auth_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/cart_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;
  final CartRepository cartRepository;
  AuthBloc(this.authRepository, {required this.cartRepository})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthButtonLoginIsClicked) {
          emit(AuthLoading());
          final response =
              await authRepository.login(event.username, event.password);
          await cartRepository.count();
          emit(AuthSuccess(authInfo: response));
        } else if (event is AuthButtonRegisterIsClicked) {
          emit(AuthLoading());
          await authRepository.register(event.phonenumber, event.phoneId);
          emit(AuthInitial());
        }
      } catch (e) {
        // Get.defaultDialog(title: e.toString());
        // emit(AuthError(e));
        emit(AuthError(AppException()));
      }
    });
  }
}
