import 'package:defood/ui/bottom_sheets/font_manager/font_manager.dart';
import 'package:defood/utils/function_name.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:stacked/stacked.dart';

class CustomFontListModel extends BaseViewModel {
  Future<void> showCustomFonts() async {
    try {
      await showFontManagerSheet();
    } catch (e) {
      FlutterLogs.logError(
        runtimeType.toString(),
        getFunctionName(),
        e.toString(),
      );
    }
  }
}
