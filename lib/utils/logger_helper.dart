import 'package:defood/utils/function_name.dart';
import 'package:flutter_logs/flutter_logs.dart';

mixin LoggerHelper {
  void logError(String message, Object error) {
    FlutterLogs.logError(
      runtimeType.toString(),
      getFunctionName(true),
      '$message: ${error.toString()}',
    );
  }

  void logInfo(String message) {
    FlutterLogs.logInfo(
      runtimeType.toString(),
      getFunctionName(true),
      message,
    );
  }
}
