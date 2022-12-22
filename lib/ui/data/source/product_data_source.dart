import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:dio/dio.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/ValidationResponse.dart';

final UiDl _dl = Get.put(UiDl());
final UserInfo _userInfo = Get.put(UserInfo());

abstract class IProductDataSource {
  Future<List<ProductEntity>> filtter(String sort);
  Future<List<ProductEntity>> getAll(int categoryId, int modelId, String model);
  Future<List<ProductEntity>> detail(int data);
  Future<List<ProductEntity>> search(String searchTerm);
  Future<List<ProductEntity>> sendLog(int id, String title, String message);
}

class ProductRemoteDataSource implements IProductDataSource {
  late final Dio httpClient;

  ProductRemoteDataSource(this.httpClient);
  @override
  Future<List<ProductEntity>> getAll(
      int categoryId, int modelId, String model) async {
    final response = await httpProduct.get('products', queryParameters: {
      "CategoryId": categoryId,
      "UserId": _dl.UserId.value,
      "SellCenter": _userInfo.sellsCenter.value,
      "ModelId": modelId,
      "Model": model,
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
    final response = await httpProduct.get('products');
    validateResponse(response);
    final products = <ProductEntity>[];

    // var element = UiProductEntity.fromJson((response.data as List).first);

    for (var element in (response.data as List)) {
      products.add(ProductEntity.fromJson(element));
    }
    return products;
  }

  @override
  Future<List<ProductEntity>> detail(int data) async {
    final response = await httpProduct.get('products', queryParameters: {
      "code": data,
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
  Future<List<ProductEntity>> sendLog(
      int id, String title, String message) async {
    // final response = await httpClient.post('path', data: {
    //   "id": id,
    //   "title": title,
    //   "message": message,
    //   "UserId": _dl.UserId.value,
    //   "SellCenter": _userInfo.sellsCenter.value,
    // });
    // validateResponse(response);
    final products = <ProductEntity>[];

    // for (var element in (response.data as List)) {
    //   products.add(ProductEntity.fromJson(element));
    // }
    return products;
  }
}
