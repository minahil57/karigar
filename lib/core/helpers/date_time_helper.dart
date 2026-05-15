import 'package:karigar/export.dart';

abstract final class DateTimeHelper {
  // 09-Oct-2021
  static DateFormat dateFormatter = DateFormat('dd-MMM-yyyy');

  // 15/10/2021 12:00:00
  static DateFormat dateTimeFormatter = DateFormat('dd/MM/yyyy HH:mm:ss');

  // '2023-12-31'
  static DateFormat apiDateFormatter = DateFormat('yyyy-MM-dd');

  static DateTime? parseDateString(String dateString) {
    // Convert month names to English
    Map<String, String> monthMap = {
      'Jan': 'January',
      'Feb': 'February',
      'Mar': 'March',
      'Apr': 'April',
      'May': 'May',
      'Jun': 'June',
      'Jul': 'July',
      'Aug': 'August',
      'Sep': 'September',
      'Oct': 'October',
      'Nov': 'November',
      'Dec': 'December',
    };

    try {
      // Extracting day, month, and year
      RegExp regExp = RegExp(r'(\d{2}) (\w+), (\d{4})');
      Match match = regExp.firstMatch(dateString)!;

      // Getting day, month, and year values
      String day = match.group(1)!;
      String monthAbbreviation = match.group(2)!;
      String year = match.group(3)!;

      // Replace abbreviated month with full month name
      String fullMonthName = monthMap[monthAbbreviation] ?? monthAbbreviation;

      // Format the date string with the corrected month name
      String formattedDateString = '$day $fullMonthName, $year';

      // Parse date using intl package with a custom format
      DateFormat dateFormat = DateFormat('dd MMMM, yyyy', 'en_US');
      DateTime parsedDate = dateFormat.parse(formattedDateString);
      return parsedDate;
    } catch (e, stackTrace) {
      AppLogger.e('Error parsing date string: $dateString');
      AppLogger.e('Exception: $e', stackTrace: stackTrace);
      return null;
    }
  }

  static bool isGivenDateInFinancialYear({
    required DateTime givenDate,
    required String financialYear,
  }) {
    bool isGivenDateInFinancialPeriod = false;
    Iterable<Match> matches = _getFinancialYearRegExpMatches(financialYear);

    if (matches.length >= 2) {
      String startDateString = matches.elementAt(0).group(0)!;
      String endDateString = matches.elementAt(1).group(0)!;

      DateTime? startDate = parseDateString(startDateString);
      DateTime? endDate = parseDateString(endDateString);

      isGivenDateInFinancialPeriod = givenDate.isBetween(
        from: startDate!,
        to: endDate!,
      );
    }

    return isGivenDateInFinancialPeriod;
  }

  static Future<DateTime?> pickDate({
    DateTime? lastDate,
    DateTime? initialDate,
    DateTime? firstDate,
  }) async {
    return showDatePicker(
      context: Get.context!,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime.now(),
    );
  }

  static DateTime get startDateOfTheCurrentYear {
    return DateTime(DateTime.now().year);
  }

  static DateTime get endDateOfTheCurrentYear {
    return DateTime(DateTime.now().year, 12, 31);
  }

  static DateTime get startDateOfTheCurrentMonth {
    return DateTime(DateTime.now().year, DateTime.now().month);
  }

  static DateTime get endDateOfTheCurrentMonth {
    return DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
  }

  static DateTime get last7Days {
    return DateTime.now().subtract(const Duration(days: 7));
  }

  static DateTime get last30Days {
    return DateTime.now().subtract(const Duration(days: 30));
  }

  static DateTime get last3Months {
    return DateTime.now().subtract(const Duration(days: 90));
  }

  static DateTime get last6Months {
    return DateTime.now().subtract(const Duration(days: 180));
  }

  static DateTime get lastYear {
    return DateTime.now().subtract(const Duration(days: 365));
  }

  // given the following Financial year String 'From 01 Jan, 2024 To 31 Dec, 2024'
  // write a function to return financialYearFrom in this format  '2021-05-15T11:09:27.212Z'

  /// Returns the start date of the financial year in ISO8601 format from the given financial year string.
  /// The financial year string should be in the format 'From 01 Jan, 2024 To 31 Dec, 2024'.
  /// The function returns an empty string if the financial year string is invalid.
  ///
  /// Example:
  ///
  /// ```dart
  /// String financialYear = 'From 01 Jan, 2024 To 31 Dec, 2024';
  /// String financialYearFrom = DateTimeHelper.getFinancialYearFrom(financialYear);
  /// print(financialYearFrom); // 2024-01-01T00:00:00.000Z
  /// ```
  static String getFinancialYearFrom(String financialYear) {
    Iterable<Match> matches = _getFinancialYearRegExpMatches(financialYear);

    if (matches.isNotEmpty) {
      String startDateString = matches.elementAt(0).group(0)!;
      DateTime? startDate = parseDateString(startDateString);
      return startDate!.toIso8601String();
    }
    return '';
  }

  /// Returns the end date of the financial year in ISO8601 format from the given financial year string.
  /// The financial year string should be in the format 'From 01 Jan, 2024 To 31 Dec, 2024'.
  /// The function returns an empty string if the financial year string is invalid.
  ///
  /// Example:
  ///
  /// ```dart
  /// String financialYear = 'From 01 Jan, 2024 To 31 Dec, 2024';
  /// String financialYearTo = DateTimeHelper.getFinancialYearTo(financialYear);
  /// print(financialYearTo); // 2024-12-31T00:00:00.000Z
  /// ```
  static String getFinancialYearTo(String financialYear) {
    Iterable<Match> matches = _getFinancialYearRegExpMatches(financialYear);

    if (matches.isNotEmpty) {
      String endDateString = matches.elementAt(1).group(0)!;
      DateTime? endDate = parseDateString(endDateString);
      return endDate!.toIso8601String();
    }
    return '';
  }

  static Iterable<Match> _getFinancialYearRegExpMatches(String financialYear) {
    RegExp dateRegExp = RegExp(r'(\d{2} \w+, \d{4})');
    return dateRegExp.allMatches(financialYear);
  }

  static String getDefaultDatetime() {
    return DateTime(1900).toIso8601String();
  }
}
