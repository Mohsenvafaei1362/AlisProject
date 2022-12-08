class TransactionListInfo {
  final int inventory;
  final int validity;

  TransactionListInfo(
    this.inventory,
    this.validity,
  );
  TransactionListInfo.fromJson(Map json)
      : inventory = json['inventory'],
        validity = json['validity'];
}
