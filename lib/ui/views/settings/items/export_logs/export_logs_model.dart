import 'package:defood/app/app.locator.dart';
import 'package:defood/models/errors/io_error.dart';
import 'package:defood/services/logs_service.dart';
import 'package:defood/utils/snackbar_helper.dart';
import 'package:stacked/stacked.dart';

class ExportLogsModel extends ReactiveViewModel with SnackbarHelper {
  final _logs = locator<LogsService>();

  Future<void> exportLogs() async {
    try {
      await _logs.exportLogs();
      showInfoSnack('Logs exported');
    } catch (e) {
      showInfoSnack(e is IOError ? e.message : e.toString());
    }
  }
}
