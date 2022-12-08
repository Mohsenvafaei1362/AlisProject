class IdentificationCodeInfo {
  final String code;

  IdentificationCodeInfo(this.code);

  IdentificationCodeInfo.fromJson(Map json) : code = json['identificationCode'];
}
