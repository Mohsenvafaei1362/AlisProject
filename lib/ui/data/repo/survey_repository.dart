import 'package:local_notification_flutter_project/ui/data/ClassInfo/survey.dart';

abstract class ISurveyRepository {
  Future<List<SurveyInfo>> surveyList();
}

class SurveyRepository implements ISurveyRepository {
  @override
  Future<List<SurveyInfo>> surveyList() {
    // TODO: implement surveyList
    throw UnimplementedError();
  }
}
