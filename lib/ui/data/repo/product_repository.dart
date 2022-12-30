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
    required int userId,
    required int sellCenter,
    required String model,
    required int visitorRef,
    required int roleRef,
    required int usersGroupRef,
  });
  Future<List<ProductEntity>> detail(int data);
  Future<List<ProductEntity>> search(String searchTerm);
  Future<void> sendLog(
    int productId,
    String sourceTitle,
    String Model,
    int userId,
    int sellsCenter,
    int categoryId,
    String event,
    int modelId,
  );
  Future<List<ProductEntity>> similar(
      int categoryId, int modelId, String model);
  Future<List<CommentProduct>> commentProduct(int productId, int sellsCenter);
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
    required int userId,
    required int sellCenter,
    required int visitorRef,
    required int roleRef,
    required int usersGroupRef,
  }) =>
      dataSource.getAll(
        categoryId: categoryId,
        model: model,
        modelId: modelId,
        roleRef: roleRef,
        sellCenter: sellCenter,
        userId: userId,
        usersGroupRef: usersGroupRef,
        visitorRef: visitorRef,
      );

  @override
  Future<List<ProductEntity>> search(String searchTerm) =>
      dataSource.search(searchTerm);

  @override
  Future<List<ProductEntity>> filtter(String sort) => dataSource.filtter(sort);

  @override
  Future<List<ProductEntity>> detail(int data) => dataSource.detail(data);

  @override
  Future<void> sendLog(
    int productId,
    String sourceTitle,
    String Model,
    int userId,
    int sellsCenter,
    int categoryId,
    String event,
    int modelId,
  ) {
    return dataSource.sendLog(
      model: Model,
      categoryId: categoryId,
      event: event,
      modelId: modelId,
      userId: userId,
      productId: productId,
      sellsCenter: sellsCenter,
      sourceTitle: sourceTitle,
    );
  }

  @override
  Future<List<ProductEntity>> similar(
      int categoryId, int modelId, String model) {
    return dataSource.similar(categoryId, modelId, model);
  }

  @override
  Future<List<CommentProduct>> commentProduct(int productId, int sellsCenter) =>
      dataSource.commentProduct(productId, sellsCenter);
}
