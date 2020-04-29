import 'package:intl/intl.dart';

class DateTimeFormatter {
  DateTimeFormatter({this.date});
  final DateTime date;

  String get dateFormat {
    return DateFormat.yMMMMd().format(date);
  }
    String get withWeekDateFormat {
    return DateFormat.yMMMMEEEEd().format(date);
  }

   String get timeFormat {
    return DateFormat.jm().format(date);
  }

  String get dateTimeFormat {
    return '$dateFormat at $timeFormat';
  }
}