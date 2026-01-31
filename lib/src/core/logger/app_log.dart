import 'package:logger/web.dart';

import 'app_log_filter.dart';

class AppLog {
  static var logger = Logger(
    printer: PrefixPrinter(
      PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 50,
        colors: true,
        printEmojis: true,
      ),
      debug: "[DEBUG] (・・;)ゞ ",
      info: "[INFO] (ﾉ´ з `)ノ ",
      warning: "[WARNING] ∑(O_O;) ",
      error: "[ERROR] (｡•̀ ⤙ •́ ｡ꐦ) !!! ",
      trace: "[TRACE] (°ロ°) ! ",
    ),
    filter: AppLogFilter(),
  );
}
