import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/CommentProduct.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:dio/dio.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/ValidationResponse.dart';

final UiDl _dl = Get.put(UiDl());
final UserInfo _userInfo = Get.put(UserInfo());

abstract class IProductDataSource {
  Future<List<ProductEntity>> filtter(String sort);
  Future<List<ProductEntity>> getAll({
    required int categoryId,
    required int modelId,
    required int userId,
    required int sellCenter,
    required String model,
    required int visitorRef,
    required int roleRef,
    required int usersGroupRef,
  });
  Future<List<ProductEntity>> detail(int data);
  Future<List<ProductEntity>> search(String searchTerm);
  Future<void> sendLog({
    required int productId,
    required String sourceTitle,
    required String model,
    required int userId,
    required int sellsCenter,
    required int categoryId,
    required String event,
    required int modelId,
  });
  Future<List<ProductEntity>> similar(
      int categoryId, int modelId, String model);
  Future<List<CommentProduct>> commentProduct(int productId, int sellsCenter);
}

class ProductRemoteDataSource implements IProductDataSource {
  late final Dio httpClient;

  ProductRemoteDataSource(this.httpClient);
  @override
  Future<List<ProductEntity>> getAll({
    required int categoryId,
    required int modelId,
    required int userId,
    required int sellCenter,
    required String model,
    required int visitorRef,
    required int roleRef,
    required int usersGroupRef,
  }) async {
    final response = await httpClient.get('ListView', queryParameters: {
      "CategoryId": categoryId,
      "UserId": userId,
      "SellsCenterId": sellCenter,
      "ModelId": modelId,
      "Model": model,
      "VisitorRef": visitorRef,
      "RoleRef": roleRef,
      "UsersGroupRef": usersGroupRef,
    });
    validateResponse(response);
    final products = <ProductEntity>[];

    // var element = UiProductEntity.fromJson((response.data as List).first);

    for (var element in (response.data as List)) {
      products.add(ProductEntity.fromJson(element));
    }
    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final response = await httpClient.get('search=$searchTerm');
    validateResponse(response);
    final products = <ProductEntity>[];
    for (var element in (response.data as List)) {
      products.add(ProductEntity.fromJson(element));
    }
    return products;
  }

  @override
  Future<List<ProductEntity>> filtter(String sort) async {
    // final response = await httpClient.get('http://185.135.229.96:806/products');
    // final response = await httpProduct.get('products');
    // validateResponse(response);
    final products = <ProductEntity>[];

    // var element = UiProductEntity.fromJson((response.data as List).first);

    // for (var element in (response.data as List)) {
    //   products.add(ProductEntity.fromJson(element));
    // }
    return products;
  }

  @override
  Future<List<ProductEntity>> detail(int data) async {
    // final response = await httpProduct.get('products', queryParameters: {
    //   "code": data,
    // });
    // validateResponse(response);
    final products = <ProductEntity>[];

    // var element = UiProductEntity.fromJson((response.data as List).first);

    // for (var element in (response.data as List)) {
    //   products.add(ProductEntity.fromJson(element));
    // }
    return products;
  }

  @override
  Future<void> sendLog({
    required int productId,
    required String sourceTitle,
    required String model,
    required int userId,
    required int sellsCenter,
    required int categoryId,
    required String event,
    required int modelId,
  }) async {
    final response = await httpClient.post('Log', data: {
      "ProductId": productId,
      "CategoryId": categoryId,
      "Event": event,
      "SourceTitle": sourceTitle,
      "Model": model,
      "ModelId": modelId,
      "UserId": userId,
      "SellsCenterId": sellsCenter,
    });
    // validateResponse(response);
    // final products = <ProductEntity>[];

    // for (var element in (response.data as List)) {
    //   products.add(ProductEntity.fromJson(element));
    // }
    // return products;
  }

  @override
  Future<List<ProductEntity>> similar(
      int categoryId, int modelId, String model) async {
    // final response = await httpClient.get('path', queryParameters: {
    //   "categoryId": categoryId,
    //   "modelId": modelId,
    //   "model": model,
    // });
    final List<ProductEntity> similar = [];
    // (response.data as List).forEach((element) {
    //   similar.add(ProductEntity.fromJson(element));
    // });
    return similar;
  }

  @override
  Future<List<CommentProduct>> commentProduct(
      int productId, int sellsCenter) async {
    final response = await httpClient.get('Comments', queryParameters: {
      "productId": productId,
      "SellsCenterId": sellsCenter,
    });

    final List<CommentProduct> comment = [];
    (response.data as List).forEach((element) {
      comment.add(CommentProduct.fromJson(element));
    });
    return comment;
  }
}
