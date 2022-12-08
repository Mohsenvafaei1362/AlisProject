class MyDeviceInfo {
  final String model;
  final String serial;
  final DateTime firstEntry;
  final DateTime lastEntry;

  MyDeviceInfo(
    this.model,
    this.serial,
    this.firstEntry,
    this.lastEntry,
  );

  MyDeviceInfo.fromJson(Map json)
      : model = json['model'],
        serial = json['serial'],
        firstEntry = json['firstEntry'],
        lastEntry = json['lastEntry'];
}
