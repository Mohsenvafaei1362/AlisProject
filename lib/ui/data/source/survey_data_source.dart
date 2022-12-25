import 'package:local_notification_flutter_project/ui/data/ClassInfo/survey.dart';

abstract class ISurveyDataSource{
  Future<List<SurveyInfo>> surveyList();
}
class SurveyRemoteDataSource implements ISurveyDataSource{
  @override
  Future<List<SurveyInfo>> surveyList() {
    // TODO: implement surveyList
    throw UnimplementedError();
  }
}