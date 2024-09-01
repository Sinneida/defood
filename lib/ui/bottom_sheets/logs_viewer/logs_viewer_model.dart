import 'package:defood/app/app.locator.dart';
import 'package:defood/services/logs_service.dart';
import 'package:defood/utils/logger_helper.dart';
import 'package:stacked/stacked.dart';

class LogsViewerModel extends ReactiveViewModel with LoggerHelper {
  final _logs = locator<LogsService>();

  final List<String> log = [];

  Future<void> getLogs() async {
    try {
      final logLines = await _logs.getLogs();
      log.addAll(logLines);
      rebuildUi();
    } catch (e) {
      logError('Failed to get logs', e);
    }
  }
}
