// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/about_app/about_app_dialog.dart';
import '../ui/dialogs/add_box/add_box_dialog.dart';

enum DialogType {
  aboutApp,
  addBox,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.aboutApp: (context, request, completer) =>
        AboutAppDialog(request: request, completer: completer),
    DialogType.addBox: (context, request, completer) =>
        AddBoxDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
