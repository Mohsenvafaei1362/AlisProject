import 'package:dio/dio.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/survey.dart';

abstract class ISurveyDataSource {
  Future<List<SurveyInfo>> surveyList();
}

class SurveyRemoteDataSource implements ISurveyDataSource {
  final Dio httpClient;

  SurveyRemoteDataSource(this.httpClient);
  @override
  Future<List<SurveyInfo>> surveyList() async {
    // final response = await httpClient.get('sur');

    final List<SurveyInfo> surveyList = [];
    // (response.data as List).forEach((element) {
    //   surveyList.add(SurveyInfo.fromJson(element));
    // });
    return surveyList;
  }
}
