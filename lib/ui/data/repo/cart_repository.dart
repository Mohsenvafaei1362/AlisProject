import 'package:local_notification_flutter_project/ui/data/ClassInfo/add_to_cart_response.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/cart_response.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/favorite_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/cart_data_source.dart';
import 'package:flutter/cupertino.dart';

final cartRepository = CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartRepository extends ICartDataSource {}

class CartRepository implements ICartRepository {
  late final ICartDataSource dataSource;
  static ValueNotifier<String> cartItemCountNotifier = ValueNotifier('0');

  CartRepository(this.dataSource);
  @override
  Future<AddToCartResponse> add(int productId) => dataSource.add(productId);

  @override
  Future<int> count() async {
    // return 0;
    final count = await dataSource.count();
    cartItemCountNotifier.value = count.toString();
    return count;
  }

  @override
  Future<void> delete(int cartItemId) => dataSource.delete(cartItemId);

  @override
  Future<List<CartResponseFake>> getAll() => dataSource.getAll();

  @override
  Future<AddToCartResponse> changeCount(int cartId, int count) =>
      dataSource.changeCount(cartId, count);

  @override
  Future<FavoriteInfo> Favorite(int productId) =>
      dataSource.Favorite(productId);
}
