import 'package:local_notification_flutter_project/ui/data/ClassInfo/category_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/category_data_source.dart';

final categoryRepository =
    CategoryRepository(CategoryRemoteDataSource(httpClient));

abstract class ICategoryRepository {
  Future<List<CategoryImageInfo>> categoryImage();
}

class CategoryRepository implements ICategoryRepository {
  final ICategoryDataSource dataSource;

  CategoryRepository(this.dataSource);
  @override
  Future<List<CategoryImageInfo>> categoryImage() => dataSource.categoryImage();
}
