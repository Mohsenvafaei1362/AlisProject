import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/product_data_source.dart';

final productRepository =
    ProductRepository(ProductRemoteDataSource(httpClient));

abstract class IProductRepository {
  Future<List<ProductEntity>> filtter(String sort);
  Future<List<ProductEntity>> getAll();
  Future<List<ProductEntity>> detail(int data);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepository {
  late final IProductDataSource dataSource;

  ProductRepository(this.dataSource);

  @override
  // Future<List<UiProductEntity>> getAll(int sort) => dataSource.getAll(sort);
  Future<List<ProductEntity>> getAll() => dataSource.getAll();

  @override
  Future<List<ProductEntity>> search(String searchTerm) =>
      dataSource.search(searchTerm);

  @override
  Future<List<ProductEntity>> filtter(String sort) => dataSource.filtter(sort);

  @override
  Future<List<ProductEntity>> detail(int data) => dataSource.detail(data);
}
