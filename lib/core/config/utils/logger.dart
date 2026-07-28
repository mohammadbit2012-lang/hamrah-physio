import 'package:logger/logger.dart';

/// AppLogger provides an organized developer logging system.
/// It wraps the 'logger' package to deliver formatted logs.
class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // No method stacktrace lines by default
      errorMethodCount: 5, // Print errors with trace lines
      lineLength: 80,
      colors: true, // Colorize messages in terminal
      printEmojis: true, // Display log type emojis
    ),
  );

  /// Debug logs - standard operational flows
  static void d(String message) => _logger.d('[Hamrah Physio] $message');

  /// Informational logs - lifecycle events, logins
  static void i(String message) => _logger.i('[Hamrah Physio] $message');

  /// Warning logs - non-fatal anomalies, missing state
  static void w(String message) => _logger.w('[Hamrah Physio] $message');

  /// Error logs - caught exceptions, crash telemetry
  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e('[Hamrah Physio ERROR] $message', error: error, stackTrace: stackTrace);
  }
}