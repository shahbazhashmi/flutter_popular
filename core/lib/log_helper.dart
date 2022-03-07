import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogHelper {
  static final bool _isLogEnabled = kDebugMode;

  static final _logger = Logger(
    printer: PrettyPrinter(),
  );

  static final _loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  static logErrorString(String string) {
    if (_isLogEnabled) _logger.e(string);
  }

  static logDebugging(String string) {
    if (_isLogEnabled) _logger.d(string);
  }

  static logInfo(String tag, String message) {
    if (_isLogEnabled) _logger.i("$tag -->> $message");
  }

  static logException(dynamic e, StackTrace s) {
    if (e is Exception) {
      if (_isLogEnabled) _logger.e(e.toString(), e, s);

      ///CrashlyticsHelper.recordError(e, s);
    }
  }
}
