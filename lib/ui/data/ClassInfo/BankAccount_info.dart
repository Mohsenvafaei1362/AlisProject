class BankAccountInfo {
  final String namebank;
  final String cardHolderName;
  final String cardNumber;
  final DateTime expiryDate;
  final String cvvCode;

  BankAccountInfo(
    this.namebank,
    this.cardHolderName,
    this.cardNumber,
    this.expiryDate,
    this.cvvCode,
  );

  BankAccountInfo.fromJson(Map json)
      : namebank = json['namebank'],
        cardHolderName = json['cardHolderName'],
        cardNumber = json['cardNumber'],
        expiryDate = json['expiryDate'],
        cvvCode = json['cvvCode'];
}
