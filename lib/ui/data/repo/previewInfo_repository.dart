import 'package:local_notification_flutter_project/ui/data/ClassInfo/previwe_Info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/previewInfo_data_source.dart';

final previewInfoRepository =
    PreviewInfoRepository(PreviewInfoRemoteDataSource(httpClient));

abstract class IPreviewINfoRepository {
  Future<List<PreviewInfoClass>> getAllInfo();
}

class PreviewInfoRepository implements IPreviewINfoRepository {
  final IPreviewInfoDataSource dataSource;
  PreviewInfoRepository(this.dataSource);
  @override
  Future<List<PreviewInfoClass>> getAllInfo() => dataSource.getAllInfo();
}
