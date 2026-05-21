import 'package:intl/intl.dart';

final _currencyFormatter = NumberFormat.currency(
  symbol: '',
  decimalDigits: 2,
  locale: 'es_AR',
);

extension PUStringFormater on String {
  String convertToCorrency() {
    final originalValue = double.tryParse(this);
    if (originalValue == null) {
      return '\$${0.00}';
    }
    return '\$${_currencyFormatter.format(originalValue)}';
  }
}

extension PUDoubleFormater on double {
  String toCurrency() {
    return '\$${_currencyFormatter.format(this)}';
  }
}
