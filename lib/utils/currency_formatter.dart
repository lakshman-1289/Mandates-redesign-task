import 'package:intl/intl.dart';

/// Formatter utility for Indian Rupee currency representations.
class CurrencyFormatter {
  CurrencyFormatter._();

  static final NumberFormat _inrFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  static final NumberFormat _inrWithDecimals = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  /// Format an amount into standard Indian currency format without decimals,
  /// e.g. 100000 -> "₹1,00,000"
  static String format(double amount) {
    return _inrFormat.format(amount);
  }

  /// Format with two decimals, e.g. 100000 -> "₹1,00,000.00"
  static String formatWithDecimals(double amount) {
    return _inrWithDecimals.format(amount);
  }
}
