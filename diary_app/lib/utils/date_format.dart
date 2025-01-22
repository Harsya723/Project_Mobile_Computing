import 'package:intl/intl.dart';

class CustomDateFormat {
  static String format(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatWithTime(DateTime date) {
    // yyyy-MM-dd HH:mm:ss
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }

  static String formatWithDay(DateTime date) {
    // Wed, 01 Jan 2020
    return DateFormat('E, dd MMM yyyy').format(date);
  }

  static String formatWithDayTime(DateTime date) {
    // Wed, 01 Jan 2020 12:00:00
    return DateFormat('E, dd MMM yyyy HH:mm').format(date);
  }

  static String formatTime(String time) {
    // Wed, 01 Jan 2020 12:00
    return time.split(':').sublist(0, 2).join(':');
  }
}