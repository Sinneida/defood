import 'package:defood/app/app.locator.dart';
import 'package:defood/models/errors/io_error.dart';
import 'package:defood/services/logs_service.dart';
import 'package:defood/utils/snackbar_helper.dart';
import 'package:stacked/stacked.dart';

class DeleteLogsModel extends BaseViewModel with SnackbarHelper {
  final _logs = locator<LogsService>();

  Future<void> deleteLogs() async {
    try {
      await _logs.deleteLogs();
      showInfoSnack('Logs deleted');
    } catch (e) {
      showInfoSnack(e is IOError ? e.message : e.toString());
    }
  }
}
