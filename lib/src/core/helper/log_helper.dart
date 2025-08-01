import 'dart:io';

import 'package:logger/logger.dart';

class LogHelper {
  LogHelper._privateConstructor();

  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 0,
      printEmojis: false,
      noBoxingByDefault: true,
    ),
  );

  static void log(dynamic data, {String? tag, dynamic name}) {
    if (Platform.isIOS) {
      _logger.d('╍' * 100);
      if (name != null) {
        _logger.d(name.runtimeType.toString());
      }
      _logger.d(data, error: tag);
    } else {
      _logger.d('╍' * 100);
      if (name != null) {
        _logger.d(name.runtimeType.toString());
        _logger.d('╍' * 100);
      }
      _logger.d(' \n');
      _logger.d(data, error: tag);
      _logger.d(' \n');
      _logger.d('╍' * 100);
    }
  }
}

extension LoggerExtension on Object {
  void log(dynamic data, {String? tag}) {
    LogHelper.log(data, tag: tag, name: this);
  }
}
