import 'package:local_notification_flutter_project/ui/data/ClassInfo/previwe_Info.dart';
import 'package:dio/dio.dart';

abstract class IPreviewInfoDataSource {
  Future<List<PreviewInfoClass>> getAllInfo();
}

class PreviewInfoRemoteDataSource implements IPreviewInfoDataSource {
  final Dio httpClient;
  PreviewInfoRemoteDataSource(this.httpClient);
  @override
  Future<List<PreviewInfoClass>> getAllInfo() async {
    final response = await httpClient.get('http://185.135.229.96:806/showinfo');
    final List<PreviewInfoClass> previewInfo = [];
    for (var element in (response.data as List<dynamic>)) {
      previewInfo.add(PreviewInfoClass.fromJson(element));
    }
    return previewInfo;
  }
}
