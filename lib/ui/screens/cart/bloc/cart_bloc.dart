import 'package:local_notification_flutter_project/ui/data/ClassInfo/auto_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/cart_response.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/cart_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStarted) {
        final authinfo = event.authInfo;
        if (authinfo == null) {
          // if (authinfo == null || authinfo.accessToken.isEmpty) {
          emit(CartAuthRequired());
        } else {
          await loadCartItems(emit, event.isRefreshing);
        }
      } else if (event is CartDeleteButtonClicked) {
        try {
          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            // final cartItem = successState.cartResponse.cartItems
            //     .firstWhere((element) => element.id == event.cartItemId);
            final index = successState.cartResponse.indexWhere(
                (element) => element.product_id == event.cartItemId);
            successState.cartResponse[index].deleteButtonLoading = true;
//            await Future.delayed(Duration(seconds: 10));
            emit(CartSuccess(successState.cartResponse));
          }
          await cartRepository.delete(event.cartItemId);
          await cartRepository.count();
          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            successState.cartResponse.removeWhere(
                (element) => element.product_id == event.cartItemId);
            if (successState.cartResponse.isEmpty) {
              emit(CartEmpty());
            } else {
              emit(CartSuccess(successState.cartResponse));
            }
          }
        } catch (e) {
          // print(e.toString());
          emit(CartError(AppException()));
        }
      } else if (event is CartAuthInfoChanged) {
        // if (event.authInfo == null || event.authInfo!.accessToken.isEmpty) {
        if (event.authInfo == null) {
          emit(CartAuthRequired());
        } else {
          if (state is CartAuthRequired) {
            await loadCartItems(emit, false);
          }
        }
      } else if (event is IncreaseCountButtonClicked ||
          event is DecreaseCountButtonClicked) {
        int cartItemId = 0;
        if (event is IncreaseCountButtonClicked) {
          cartItemId = event.cartItemId;
        } else if (event is DecreaseCountButtonClicked) {
          cartItemId = event.cartItemId;
        }
        try {
          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            // final cartItem = successState.cartResponse.cartItems
            //     .firstWhere((element) => element.id == event.cartItemId);
            final index = successState.cartResponse
                .indexWhere((element) => element.product_id == cartItemId);
            // successState.cartResponse.changeCountLoading =
            //     true;
            // final index = successState.cartResponse.cartItems
            //     .indexWhere((element) => element.id == cartItemId);
            // successState.cartResponse.cartItems[index].changeCountLoading =
            //     true;
            emit(CartSuccess(successState.cartResponse));
            final newCount = event is IncreaseCountButtonClicked
                ? ++successState.cartResponse[index].product_code
                : --successState.cartResponse[index].product_code;
            await cartRepository.changeCount(cartItemId, newCount);
            await cartRepository.count();
            // if (state is CartSuccess) {
            //   final successState = (state as CartSuccess);
            successState.cartResponse
                .firstWhere((element) => element.product_id == cartItemId)
                .product_code = newCount;

            // emit(CartSuccess(successState.cartResponse));
            emit(calculatePriceInfo(successState.cartResponse));
          }
          // }
        } catch (e) {
          // print(e.toString());
          emit(CartError(AppException()));
        }
      }
    });
  }
  Future<void> loadCartItems(Emitter<CartState> emit, bool isRefreshing) async {
    try {
      if (!isRefreshing) {
        emit(CartLoading());
      }
      final result = await cartRepository.getAll();
      if (result.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartSuccess(result));
      }
    } catch (e) {
      emit(CartError(AppException()));
    }
    // try {
    //   if (!isRefreshing) {
    //     emit(CartLoading());
    //   }
    //   final result = await cartRepository.getAll();
    //   if (result.cartItems.isEmpty) {
    //     emit(CartEmpty());
    //   } else {
    //     emit(CartSuccess(result));
    //   }
    // } catch (e) {
    //   emit(CartError(AppException()));
    // }
  }

  CartSuccess calculatePriceInfo(List<CartResponseFake> cartResponse) {
    // int totalPrice = 0;
    // int payablePrice = 0;
    // int shippingCost = 0;

    // for (var cartItem in cartResponse.cartItems) {
    //   totalPrice += cartItem.product.previousPrice * cartItem.count;
    //   payablePrice += cartItem.product.price * cartItem.count;
    // }

    // shippingCost = payablePrice >= 250000 ? 0 : 30000;

    // cartResponse.totalPrice = totalPrice;
    // cartResponse.payablePrice = payablePrice;
    // cartResponse.shippingCost = shippingCost;

    // return CartSuccess(cartResponse);
    double totalPrice = 0.0;
    double payablePrice = 0.0;
    double shippingCost = 0.0;

    cartResponse.forEach((cartItem) {
      totalPrice += cartItem.product_price * cartItem.product_code;
      payablePrice += cartItem.product_price * cartItem.product_code;
    });
    shippingCost = payablePrice >= 10 ? 0 : 30000;
    // cartResponse.totalPrice = totalPrice;
    // cartResponse.payablePrice = payablePrice;
    // cartResponse.shippingConst = shippingCost;
    return CartSuccess(cartResponse);
  }
}
