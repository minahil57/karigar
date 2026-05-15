import 'package:karigar/export.dart';

final Interceptor loggerInterceptor = TalkerDioLogger(
  settings: TalkerDioLoggerSettings(
    requestPen: AnsiPen()..blue(bold: true),
    printRequestHeaders: true,
  ),
);
