import 'dart:developer' as Developer;

import 'app_configuration.dart';

class Logger {
//

  Logger._();

  static log(String message) {
    if (!AppConfiguration.isHttpLoggerEnabled) return;
    Developer.log(message);
  }

//
}
