import 'package:logger/web.dart';
import 'package:flutter/foundation.dart';

class AppLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode;
  }
}
