class LowInfo {
  final int RegisterMemberLevelId;

  LowInfo(
    this.RegisterMemberLevelId,
  );
  LowInfo.fromJson(Map json)
      : RegisterMemberLevelId = json['registerMemberLevelId'];
}
