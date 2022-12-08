class PartnersInfo {
  final String name;
  final String reward; //پاداش

  PartnersInfo(
    this.name,
    this.reward,
  );
  PartnersInfo.fromJson(Map json)
      : name = json['name'],
        reward = json['reward'];
}
