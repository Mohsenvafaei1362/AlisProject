import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

extension PriceLable on int {
  String get withPriceLable => this > 0 ? '$separateByComma  تومان' : 'رایگان';

  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}

// extension PriceLablenum on num {
//   String get withPriceLable => this > 0 ? '$separateByComma  تومان' : 'رایگان';

//   String get separateByComma {
//     final numberFormat = NumberFormat.decimalPattern();
//     return numberFormat.format(this);
//   }
// }

extension PriceLabledouble on double {
  String get withPriceLable => this > 0 ? '$separateByComma  تومان' : 'رایگان';

  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}

extension PriceLablenum on num {
  String get withPriceLable => this > 0 ? '$separateByComma  تومان' : 'رایگان';

  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}

extension PriceLableString on String {
  String get withPriceLableString =>
      this != '0' ? '$separateByComma  تومان' : 'رایگان';

  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}

extension PriceLableNum on num {
  String get withPriceLableString =>
      this > 0 ? '$separateByComma  تومان' : 'رایگان';

  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}

extension DiscountLable on String {
  String get withDiscountLable => '$this %';
}
