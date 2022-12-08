import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/cart_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ICartRepository cartRepository;
  final IProductRepository productRepository;
  ProductsBloc({required this.cartRepository, required this.productRepository})
      : super(ProductFiltterLoading()) {
    on<ProductsEvent>(
      (event, emit) async {
        try {
          if (event is ProductAddToCartButtonClicked) {
            emit(
              ProductAddToCartBttonLoading(),
            );
            final result = await cartRepository.add(event.productId);
            await cartRepository.count();
            emit(
              ProductAddToCartSuccess(),
            );
          } else if (event is ProductAddToFavoriteButtonClicked) {
            emit(
              ProductAddToCartBttonLoading(),
            );
            final response = await cartRepository.Favorite(event.productId);
            emit(
              ProductAddToCartSuccess(),
            );
          } else if (event is ProductStarted) {
            emit(ProductFiltterLoading());
            // await Future.delayed(Duration(seconds: 5));
            final result = await productRepository.filtter(event.sort);
            emit(ProductFiltterSuccess(result));
          }
        } catch (e) {
          emit(
            ProductAddToCartError(
              AppException(),
            ),
          );
        }
      },
    );
  }
}
