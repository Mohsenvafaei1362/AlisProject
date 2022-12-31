import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/CommentProduct.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/promotion.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/cart_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_notification_flutter_project/ui/data/repo/promotion_repository.dart';

part 'detailes_event.dart';
part 'detailes_state.dart';

final UiDl _dl = Get.put(UiDl());
final UserInfo _userinfo = Get.put(UserInfo());

var similars, comments, properties, promotions;

class DetailesBloc extends Bloc<DetailesEvent, DetailesState> {
  final IProductRepository productRepository;
  final IPromotionRepository promotionRepository;
  DetailesBloc(
      {required this.productRepository, required this.promotionRepository})
      : super(DetailesLoading()) {
    on<DetailesEvent>((event, emit) async {
      try {
        if (event is DetailesStarted) {
          emit(DetailesLoading());
          final similar = await productRepository.Promotion(
            poductId: event.productId,
            categoryId: 0,
            modelId: 5,
            model: 'Promotion',
            roleRef: _userinfo.RoleId.value,
            sellCenter: _userinfo.sellsCenter.value,
            userId: _dl.UserId.value,
            usersGroupRef: _userinfo.userGroups.value,
            visitorRef: _userinfo.visitor.value,
          ); //محصولات مشابه
          final property = await productRepository.property(
            event.productId,
            event.sellsCenter,
          ); //ویژگی های محصول
          final comment = await productRepository.commentProduct(
            event.productId,
            event.sellsCenter,
          ); //کامنت ها
          // final promotion = await promotionRepository.promotionList(
          //   categoryId: 1,
          //   model: '',
          //   modelId: 1,
          //   roleRef: _userinfo.RoleId.value,
          //   poductId: event.productId,
          //   sellCenter: event.sellsCenter,
          //   userId: _userinfo.UserId.value,
          //   usersGroupRef: _userinfo.userGroups.value,
          //   visitorRef: _userinfo.visitor.value,
          // ); //پروموشن
          similars = similar;
          comments = comment;
          properties = property;
          // promotions = promotion;
          emit(DetailesSuccess(similar, comment, property));
        } else if (event is DetailesClickedButton) {
          emit(DetailesLoading());
          final liked = await productRepository.liked(
            liked: event.liked,
            name: event.name,
            productId: event.productId,
            sellsCenter: event.sellsCenter,
            userId: event.userRef,
            commentId: event.commentRef,
          ); //می پسندم / نمی پسندم
          emit(DetailesSuccess(similars, comments, properties));
        }
      } catch (e) {
        emit(DetailesError(AppException()));
      }
    });
  }
}
