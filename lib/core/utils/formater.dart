import 'package:karigar/export.dart';

class Formatter {
  /// Format money without a symbol (2,250,000.00)
  static String formatToMoney(double value) {
    return NumberFormat.currency(symbol: '', decimalDigits: 2).format(value);
  }
}
