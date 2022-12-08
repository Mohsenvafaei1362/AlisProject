class GholeInfo {
  final String LevelTitr;
  final String LevelDesc;
  final String Avatar;
  final int LevelMinValue;
  final int LevelMaxValue;
  final int LevelValue;
  final int LevelCount;
  final int RoleRef;

  GholeInfo(
    this.LevelTitr,
    this.LevelDesc,
    this.LevelMinValue,
    this.LevelMaxValue,
    this.LevelValue,
    this.LevelCount,
    this.RoleRef,
    this.Avatar,
  );
  GholeInfo.fromJson(Map json)
      : LevelTitr = json['levelTitr'],
        LevelDesc = json['levelDesc'],
        LevelMinValue = json['levelMinValue'],
        LevelMaxValue = json['levelMaxValue'],
        LevelValue = json['levelValue'],
        LevelCount = json['levelCount'],
        RoleRef = json['roleRef'],
        Avatar = json['avatar'];
}
