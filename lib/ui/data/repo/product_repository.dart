import 'package:local_notification_flutter_project/ui/data/ClassInfo/CommentProduct.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/product_data_source.dart';

final productRepository =
    ProductRepository(ProductRemoteDataSource(httpClient));

abstract class IProductRepository {
  Future<List<ProductEntity>> filtter(String sort);
  Future<List<ProductEntity>> getAll({
    required int categoryId,
    required int modelId,
    required String model,
  });
  Future<List<ProductEntity>> detail(int data);
  Future<List<ProductEntity>> search(String searchTerm);
  Future<List<ProductEntity>> sendLog(int id, String title, String message);
  Future<List<ProductEntity>> similar(
      int categoryId, int modelId, String model);
  Future<List<CommentProduct>> commentProduct(int productId);
}

class ProductRepository implements IProductRepository {
  late final IProductDataSource dataSource;

  ProductRepository(this.dataSource);

  @override
  // Future<List<UiProductEntity>> getAll(int sort) => dataSource.getAll(sort);
  Future<List<ProductEntity>> getAll({
    required int categoryId,
    required int modelId,
    required String model,
  }) =>
      dataSource.getAll(
        categoryId,
        modelId,
        model,
      );

  @override
  Future<List<ProductEntity>> search(String searchTerm) =>
      dataSource.search(searchTerm);

  @override
  Future<List<ProductEntity>> filtter(String sort) => dataSource.filtter(sort);

  @override
  Future<List<ProductEntity>> detail(int data) => dataSource.detail(data);

  @override
  Future<List<ProductEntity>> sendLog(int id, String title, String message) {
    return dataSource.sendLog(id, title, message);
  }

  @override
  Future<List<ProductEntity>> similar(
      int categoryId, int modelId, String model) {
    return dataSource.similar(categoryId, modelId, model);
  }

  @override
  Future<List<CommentProduct>> commentProduct(int productId) =>
      dataSource.commentProduct(productId);
}
