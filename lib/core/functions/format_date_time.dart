import 'package:intl/intl.dart';

String formatDateTime(DateTime? dateTime) {
  if (dateTime == null) return '';

  return DateFormat('d MMM • h:mm a').format(dateTime.toLocal());
}
