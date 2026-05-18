import 'package:intl/intl.dart';

String formatToLocalDate(String? dateStr, {String format = 'dd MMM yyyy'}) {
  if (dateStr == null || dateStr.isEmpty) return '';
  try {
    final dateTime = DateTime.parse(dateStr).toLocal();
    return DateFormat(format).format(dateTime);
  } catch (e) {
    return dateStr;
  }
}
