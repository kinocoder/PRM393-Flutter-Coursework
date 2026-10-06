import 'package:intl/intl.dart';

final _currencyFormat = NumberFormat.currency(
  locale: 'vi_VN',
  name: 'VND',
  symbol: 'VND',
  decimalDigits: 0,
);

String formatVnd(num amount) {
  return _currencyFormat.format(amount);
}