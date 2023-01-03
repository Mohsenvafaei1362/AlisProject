import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

final UiDl _dl = Get.put(UiDl());
final UserInfo _userinfo = Get.put(UserInfo());

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final IProductRepository productRepository;
  ProductListBloc(this.productRepository) : super(ProductListLoading()) {
    on<ProductListEvent>((event, emit) async {
      if (event is ProductListStarted) {
        try {
          emit(ProductListLoading());
          final products = await productRepository.getAll(
            categoryId: event.categoryId,
            modelId: event.modelId,
            model: event.modelName,
            roleRef: event.roleRef,
            sellCenter: event.sellCenter,
            userId: event.userId,
            usersGroupRef: event.usersGroupRef,
            visitorRef: event.visitorRef,
          );
          emit(ProductListSuccess(
            products,
            event.categoryId,
            UiProductSort.names,
          ));
        } catch (e) {
          emit(ProductListError(AppException()));
        }
      }
    });
  }
}
