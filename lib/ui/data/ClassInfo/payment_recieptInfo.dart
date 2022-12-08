class PaymentRecieptData {
  final bool purchaseSuccess;
  final int payablePrice;
  final String paymentStatus;

  PaymentRecieptData.fromJson(Map<String, dynamic> json)
      : purchaseSuccess = json['purchaseSuccess'],
        payablePrice = json['payablePrice'],
        paymentStatus = json['paymentStatus'];
}
