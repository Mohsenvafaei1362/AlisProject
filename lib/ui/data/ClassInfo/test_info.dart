class TestInfo {
  final String access_token;
  final String refresh_token;

  TestInfo(this.access_token, this.refresh_token);

  TestInfo.fromJson(Map json)
      : access_token = json['access_token'],
        refresh_token = json['refresh_token'];
}
