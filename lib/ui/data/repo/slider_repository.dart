import 'package:local_notification_flutter_project/ui/data/ClassInfo/sliderInfo.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/slider_data_source.dart';

final sliderRepository = SliderRepository(SliderRemoteDataSource(httpClient));

abstract class ISliderRepository {
  Future<List<SliderInfo>> getImage(String sliderGroup); //abstract method
}

class SliderRepository implements ISliderRepository {
  final ISliderDataSource dataSource;
  SliderRepository(this.dataSource);
  @override
  Future<List<SliderInfo>> getImage(String sliderGroup) =>
      dataSource.getImage(sliderGroup);
}
