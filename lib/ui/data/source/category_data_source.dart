import 'package:local_notification_flutter_project/ui/data/ClassInfo/category_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:dio/dio.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/ValidationResponse.dart';

abstract class ICategoryDataSource {
  Future<List<CategoryImageInfo>> categoryImage();
}

class CategoryRemoteDataSource implements ICategoryDataSource {
  final Dio httpClient;

  CategoryRemoteDataSource(this.httpClient);
  @override
  Future<List<CategoryImageInfo>> categoryImage() async {
    // final response = await httpClient.get('imagecategory');
    // await httpClient.get('http://185.135.229.96:806/imagecategory');
    final List<CategoryImageInfo> categoryImage = [];
    // print(response.data.toString());
    // validateResponse(response);
    // for (var element in (response.data as List)) {
    //   categoryImage.add(CategoryImageInfo.fromJson(element));
    // }
    return categoryImage;
  }
}
