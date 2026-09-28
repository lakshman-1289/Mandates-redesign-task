import 'package:intl/intl.dart';

/// Formatter utility for dates displayed throughout the mandates flow.
class DateFormatter {
  DateFormatter._();

  static final DateFormat _standardDate = DateFormat('dd MMM yyyy');
  static final DateFormat _fullDate = DateFormat('dd MMMM yyyy');

  /// Format date as "22 Nov 2022"
  static String format(DateTime date) {
    return _standardDate.format(date);
  }

  /// Format date as "22 November 2022"
  static String formatFull(DateTime date) {
    return _fullDate.format(date);
  }
}
