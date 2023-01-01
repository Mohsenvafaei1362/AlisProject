import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/add_to_cart_response.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/cart_response.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/favorite_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:dio/dio.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/ValidationResponse.dart';

final UiDl _dl = Get.put(UiDl());

abstract class ICartDataSource {
  Future<AddToCartResponse> add(
    int productId,
    int count,
    double price,
    int takhfif,
    int etebar,
    int emtiaz,
    int userId,
    int dlRef,
    int listViewDetailRef,
    String productName,
    int sellsCenterId,
    int categoriesId,
    int userGroupId,
    int visitorId,
    double lat,
    double long,
  );
  Future<FavoriteInfo> Favorite(int productId);
  Future<AddToCartResponse> changeCount(int cartId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<List<CartResponseFake>> getAll();
}

class CartRemoteDataSource implements ICartDataSource {
  late final Dio httpClient;
  CartRemoteDataSource(this.httpClient);
  @override
  Future<AddToCartResponse> add(
    int productId,
    int count,
    double price,
    int takhfif,
    int etebar,
    int emtiaz,
    int userId,
    int dlRef,
    int listViewDetailRef,
    String productName,
    int sellsCenterId,
    int categoriesId,
    int userGroupId,
    int visitorId,
    double lat,
    double long,
  ) async {
    final response = await httpClient.post('path', data: {
      "product_id": productId,
      "Count": count,
      "Price": price,
      "Takhfif": takhfif,
      "Etebar": etebar,
      "Emtiaz": emtiaz,
      "UserRef": userId,
      "DlRef": dlRef,
      "ListViewDetailRef": listViewDetailRef,
      "ProductName": productName,
      "SellsCenterId": sellsCenterId,
      "CategoriesId": categoriesId,
      "UserGroupId": userGroupId,
      "VisitorId": visitorId,
      "Lat": lat,
      "Long": long,
    });
    validateResponse(response);
    return AddToCartResponse.fromJson(response.data);
  }

  @override
  Future<AddToCartResponse> changeCount(int cartItemId, int count) async {
    final response = await httpClient.post('cart/changeCount',
        data: {'cart_item_id': cartItemId, 'count': count});
// validateResponse(response);
    return AddToCartResponse.fromJson(response.data);
  }

  @override
  Future<int> count() async {
    final response = await httpProduct.get('products');
    final List<CartResponseFake> cart = [];
    (response.data as List).forEach((element) {
      cart.add(CartResponseFake.fromJson(element));
    });
    // validateResponse(response);
    return cart.length;
  }

  @override
  Future<void> delete(int cartItemId) async {
    await httpClient.post('cart/remove', data: {'cart_item_id': cartItemId});
  }

  @override
  Future<List<CartResponseFake>> getAll() async {
    final response = await httpProduct.get('products', queryParameters: {
      "user_id": _dl.UserId.value,
    });
    final List<CartResponseFake> cart = [];
    // validateResponse(response);
    (response.data as List).forEach((element) {
      cart.add(CartResponseFake.fromJson(element));
    });
    return cart;
  }

  @override
  Future<FavoriteInfo> Favorite(int productId) async {
    final response = await httpClient.post(
      'path',
      data: {
        "product_id": productId,
      },
    );
    // validateResponse(response);
    return FavoriteInfo.formJson(response.data);
  }
}
