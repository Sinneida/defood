import 'package:defood/app/app.locator.dart';
import 'package:defood/services/logs_service.dart';
import 'package:defood/ui/bottom_sheets/logs_viewer/logs_viewer.dart';
import 'package:defood/utils/logger_helper.dart';
import 'package:defood/utils/snackbar_helper.dart';
import 'package:stacked/stacked.dart';

class ShowLogsModel extends BaseViewModel with SnackbarHelper, LoggerHelper {
  final _logs = locator<LogsService>();

  Future<void> showLogsViewer({bool raw = false}) async {
    try {
      final logsDir = await _logs.getLogsDir();
      if (_logs.areLogsPresent(logsDir)) {
        showLogsViewSheet(raw: raw);
      } else {
        showInfoSnack('No logs to show');
      }
    } catch (e) {
      showInfoSnack('Error showing logs');
      logError('Failed to show logs viewer', e);
    }
  }
}
