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

var similars, comments, properties, promotions, productDetailes, productCounts;

class DetailesBloc extends Bloc<DetailesEvent, DetailesState> {
  final IProductRepository productRepository;
  final IPromotionRepository promotionRepository;
  final ICartRepository cartRepository;
  DetailesBloc(
      {required this.productRepository,
      required this.promotionRepository,
      required this.cartRepository})
      : super(DetailesLoading()) {
    on<DetailesEvent>((event, emit) async {
      try {
        if (event is DetailesStarted) {
          emit(DetailesLoading());
          final similar = await productRepository.Promotion(
            poductId: event.listViewDetailId,
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
            event.listViewDetailId,
            event.sellsCenter,
          ); //ویژگی های محصول
          final comment = await productRepository.commentProduct(
            event.listViewDetailId,
            event.sellsCenter,
          ); //کامنت ها
          final productDetaile =
              await productRepository.productDetaile(event.listViewDetailId);
          final productCount = await productRepository.productCount(
            poductId: event.productId,
            categoryId: event.categoryId,
            modelId: event.modelId,
            userId: event.userId,
            sellCenter: event.sellsCenter,
            model: event.model,
            visitorRef: event.visitorRef,
            roleRef: event.roleRef,
            usersGroupRef: event.usersGroupRef,
          );
          similars = similar;
          comments = comment;
          properties = property;
          productDetailes = productDetaile;
          productCounts = productCount;
          // promotions = promotion;
          emit(DetailesSuccess(
              similar, comment, property, productDetaile, productCount));
        } else if (event is DetailesLikeClickedButton) {
          emit(DetailesLoading());
          final liked = await productRepository.liked(
            liked: event.liked,
            name: event.name,
            productId: event.productId,
            sellsCenter: event.sellsCenter,
            userId: event.userRef,
            commentId: event.commentRef,
          ); //می پسندم / نمی پسندم
          emit(DetailesSuccess(
              similars, comments, properties, productDetailes, productCounts));
        } else if (event is DetailesIncrementClickedButton) {
          emit(DetailesLoading());
        } else if (event is DetailesDecrementClickedButton) {
          emit(DetailesLoading());
        } else if (event is DetailesAddToCartButtonClicked) {
          emit(DetailesLoading());

          final result = await cartRepository.add(
            event.productId,
            event.count,
            event.price,
            event.takhfif,
            event.etebar,
            event.emtiaz,
            event.userId,
            event.dlRef,
            event.listViewDetailRef,
            event.productName,
            event.sellsCenterId,
            event.categoriesId,
            event.userGroupId,
            event.visitorId,
            event.lat,
            event.long,
          );
          emit(DetailesSuccess(
              similars, comments, properties, productDetailes, productCounts));
        } else if (event is DetailAddToFavoriteButtonClicked) {
          emit(DetailesLoading());
          final response = await cartRepository.Favorite(event.productId);
          emit(DetailesSuccess(
              similars, comments, properties, productDetailes, productCounts));
        }
      } catch (e) {
        emit(DetailesError(AppException()));
      }
    });
  }
}
