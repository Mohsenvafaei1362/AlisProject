import 'package:local_notification_flutter_project/ui/data/ClassInfo/survey.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/survey_data_source.dart';

final surveyRepository = SurveyRepository(SurveyRemoteDataSource(httpClient));

abstract class ISurveyRepository {
  Future<List<SurveyInfo>> surveyList();
}

class SurveyRepository implements ISurveyRepository {
  final ISurveyDataSource dataSource;

  SurveyRepository(this.dataSource);
  @override
  Future<List<SurveyInfo>> surveyList() => dataSource.surveyList();
}
