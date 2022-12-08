class ClubInfo {
  final int Value;

  ClubInfo(this.Value);
  ClubInfo.fromJson(Map json) : Value = json['value'];
}
