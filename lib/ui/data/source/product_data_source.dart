import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:dio/dio.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> filtter(String sort);
  Future<List<ProductEntity>> getAll();
  Future<List<ProductEntity>> detail(int data);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource implements IProductDataSource {
  late final Dio httpClient;

  ProductRemoteDataSource(this.httpClient);
  @override
  // Future<List<UiProductEntity>> getAll(int sort) async {
  Future<List<ProductEntity>> getAll() async {
    // final response = await httpClient.get('http://185.135.229.96:806/products');
    final response = await httpProduct.get(
      'products',
    );
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

  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
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
}
