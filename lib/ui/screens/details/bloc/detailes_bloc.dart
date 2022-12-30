import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/CommentProduct.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/cart_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detailes_event.dart';
part 'detailes_state.dart';

final UiDl _dl = Get.put(UiDl());
final UserInfo _userinfo = Get.put(UserInfo());

class DetailesBloc extends Bloc<DetailesEvent, DetailesState> {
  final IProductRepository productRepository;
  DetailesBloc({required this.productRepository}) : super(DetailesLoading()) {
    on<DetailesEvent>((event, emit) async {
      try {
        if (event is DetailesStarted) {
          emit(DetailesLoading());
          final response = await productRepository.detail(event.productId);
          final similar = await productRepository.getAll(
            categoryId: event.productId,
            modelId: 1,
            model: '',
            roleRef: _userinfo.RoleId.value,
            sellCenter: _userinfo.sellsCenter.value,
            userId: _dl.UserId.value,
            usersGroupRef: _userinfo.userGroups.value,
            visitorRef: _userinfo.visitor.value,
          ); //محصولات مشابه
          final comment = await productRepository.commentProduct(
            event.productId,
            event.sellsCenter,
          ); //کامنت ها
          emit(DetailesSuccess(response, similar, comment));
        }
      } catch (e) {
        emit(DetailesError(AppException()));
      }
    });
  }
}
