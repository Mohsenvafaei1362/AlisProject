class ReciveCodeInfo {
  final int count;

  ReciveCodeInfo(
    this.count,
  );
  ReciveCodeInfo.fromJson(Map json) : count = json['count'];
}
