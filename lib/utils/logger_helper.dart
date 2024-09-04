import 'package:defood/models/errors/base/app_error.dart';
import 'package:defood/utils/function_name.dart';
import 'package:flutter_logs/flutter_logs.dart';

mixin LoggerHelper {
  void logError(String message, dynamic error) {
    FlutterLogs.logError(
      runtimeType.toString(),
      getFunctionName(true),
      '$message: ${error is AppError ? error.fullMessage() : error.toString()}',
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
