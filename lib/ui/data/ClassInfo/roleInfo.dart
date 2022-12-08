class RoleInfo {
  final bool created;
  RoleInfo(
    this.created,
  );
  RoleInfo.fromJson(Map json) : created = json['created'];
}
