// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/about_app/about_app_dialog.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';

enum DialogType {
  infoAlert,
  aboutApp,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    DialogType.aboutApp: (context, request, completer) =>
        AboutAppDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
