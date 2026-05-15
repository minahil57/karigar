import 'package:karigar/export.dart';

abstract final class AppLogger {
  static final _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  /// Log a message at level Level.trace.
  static void t(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.t(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level Level.debug.
  static void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level Level.info.
  static void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.i(message, time: time, error: error, stackTrace: stackTrace);
  }

  // Log a message at level Level.warning.
  static void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.w(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level Level.error.
  static void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level Level.fatal.
  static void f(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.f(message, time: time, error: error, stackTrace: stackTrace);
  }
}
