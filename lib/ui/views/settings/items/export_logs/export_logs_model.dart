import 'package:defood/app/app.locator.dart';
import 'package:defood/models/errors/io_error.dart';
import 'package:defood/services/logs_service.dart';
import 'package:defood/utils/notification_helper.dart';
import 'package:stacked/stacked.dart';

class ExportLogsModel extends ReactiveViewModel with NotificationHelper {
  final _logs = locator<LogsService>();

  Future<void> exportLogs() async {
    try {
      await _logs.exportLogs();
      notifyInfo('Logs exported');
    } catch (e) {
      notifyInfo(e is IOError ? e.message : e.toString());
    }
  }
}
