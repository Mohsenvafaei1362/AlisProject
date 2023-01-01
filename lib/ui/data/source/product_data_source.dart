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
  Future<List<ProductEntity>> productDetaile(int productId);
  Future<void> increment({required int productId, required int count});
  Future<void> decrement({required int productId, required int count});
  Future<List<PropertyEntity>> property(int productId, int sellsCenterId);
  Future<List<PromotionEntity>> Promotion({
    required int poductId,
    required int categoryId,
    required int modelId,
    required int userId,
    required int sellCenter,
    required String model,
    required int visitorRef,
    required int roleRef,
    required int usersGroupRef,
  });
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
  Future<void> liked(
    String name,
    int userId,
    int commentId,
    int productId,
    int sellsCenter,
    bool liked,
  );
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
  Future<void> liked(
    String name,
    int userId,
    int commentId,
    int productId,
    int sellsCenter,
    bool liked,
  ) async {
    final response = await httpClient.post('Comments', data: {
      "Name": name,
      "UserRef": userId,
      "ProductId": productId,
      "SellsCenterId": sellsCenter,
      "Liked": liked,
      "CommentsRef": commentId,
    });
    // validateResponse(response);
    // final like = <CommentProduct>[];

    // // var element = CommentProduct.fromJson((response.data as List).first);

    // for (var element in (response.data as List)) {
    //   like.add(CommentProduct.fromJson(element));
    // }
    // return like;
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

  @override
  Future<List<PropertyEntity>> property(
    int productId,
    int sellsCenterId,
  ) async {
    final response = await httpClient.get(
      'ProductDetails',
      queryParameters: {
        "ProductId": productId,
        "SellsCenterId": sellsCenterId,
      },
    );
    validateResponse(response);
    final List<PropertyEntity> properties = [];
    (response.data as List).forEach((element) {
      properties.add(PropertyEntity.fromJson(element));
    });
    return properties;
  }

  @override
  Future<List<PromotionEntity>> Promotion({
    required int poductId,
    required int categoryId,
    required int modelId,
    required int userId,
    required int sellCenter,
    required String model,
    required int visitorRef,
    required int roleRef,
    required int usersGroupRef,
  }) async {
    final response = await httpClient.get('Promotion', queryParameters: {
      "CategoryId": categoryId,
      "UserId": userId,
      "SellsCenterId": sellCenter,
      "ModelId": modelId,
      "Model": model,
      "VisitorRef": visitorRef,
      "RoleRef": roleRef,
      "UsersGroupRef": usersGroupRef,
      "ProductId": poductId,
    });

    validateResponse(response);
    final List<PromotionEntity> promotion = [];
    (response.data as List).forEach((element) {
      promotion.add(PromotionEntity.fromJson(element));
    });
    return promotion;
  }

  @override
  Future<void> decrement({required int productId, required int count}) async {
    final response = await httpClient.post('');
  }

  @override
  Future<void> increment({required int productId, required int count}) async {
    final response = await httpClient.post('path');
  }

  @override
  Future<List<ProductEntity>> productDetaile(int productId) async {
    final response = await httpClient.get('ListViewById', queryParameters: {
      "ListViewDetailId": productId,
    });
    validateResponse(response);
    final List<ProductEntity> productDetail = [];
    (response.data as List).forEach((element) {
      productDetail.add(ProductEntity.fromJson(element));
    });
    return productDetail;
  }
}
