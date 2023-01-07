import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

extension PriceLable on int {
  String get withPriceLable => '$separateByComma  تومان';

  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}

extension PriceLabledouble on double {
  String get withPriceLableDouble => '$separateByComma  تومان';

  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}

extension PriceLableString on String {
  String get withPriceLableString => '$separateByComma  تومان';

  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(int.parse(this));
  }
}

extension PriceLableNum on num {
  String get withPriceLableNum => '$separateByComma  تومان';

  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}

extension PriceLableNumShippingCost on num {
  String get withPriceLableNumShippingCost =>
      this > 0 ? '$separateByComma  تومان' : 'رایگان';

  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}

extension DiscountLable on String {
  String get withDiscountLable => '$this %';
}
