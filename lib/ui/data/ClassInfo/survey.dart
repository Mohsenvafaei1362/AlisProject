class SurveyInfo {
  final int id;
  final String title;

  SurveyInfo(this.id, this.title);

  SurveyInfo.fromJson(Map json)
      : id = json["id"],
        title = json["title"];
}
