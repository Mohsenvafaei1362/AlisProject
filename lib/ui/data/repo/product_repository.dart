import 'package:local_notification_flutter_project/ui/data/ClassInfo/CommentProduct.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/product_data_source.dart';

final productRepository =
    ProductRepository(ProductRemoteDataSource(httpClient));

abstract class IProductRepository {
  Future<List<ProductEntity>> filtter(String sort);
  Future<List<ProductEntity>> productDetaile(int productId);
  Future<List<ProductEntity>> productCount({
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
  Future<void> liked({
    required String name,
    required int userId,
    required int commentId,
    required int productId,
    required int sellsCenter,
    required bool liked,
  });
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
  Future<void> liked({
    required String name,
    required int userId,
    required int commentId,
    required int productId,
    required int sellsCenter,
    required bool liked,
  }) =>
      dataSource.liked(
        name,
        userId,
        commentId,
        productId,
        sellsCenter,
        liked,
      );

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

  @override
  Future<List<PropertyEntity>> property(int productId, int sellsCenterId) =>
      dataSource.property(productId, sellsCenterId);

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
  }) {
    return dataSource.Promotion(
      poductId: poductId,
      categoryId: categoryId,
      modelId: modelId,
      userId: userId,
      sellCenter: sellCenter,
      model: model,
      visitorRef: visitorRef,
      roleRef: roleRef,
      usersGroupRef: usersGroupRef,
    );
  }

  @override
  Future<void> increment({required int productId, required int count}) =>
      dataSource.increment(productId: productId, count: count);

  @override
  Future<void> decrement({required int productId, required int count}) =>
      dataSource.decrement(productId: productId, count: count);

  @override
  Future<List<ProductEntity>> productDetaile(int productId) =>
      dataSource.productDetaile(productId);

  @override
  Future<List<ProductEntity>> productCount({
    required int poductId,
    required int categoryId,
    required int modelId,
    required int userId,
    required int sellCenter,
    required String model,
    required int visitorRef,
    required int roleRef,
    required int usersGroupRef,
  }) {
    return dataSource.productCount(
      categoryId: categoryId,
      modelId: modelId,
      userId: userId,
      model: model,
      poductId: poductId,
      roleRef: roleRef,
      sellCenter: sellCenter,
      usersGroupRef: usersGroupRef,
      visitorRef: visitorRef,
    );
  }
}
