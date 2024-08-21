import 'package:defood/services/custom_themes_service.dart';
import 'package:defood/services/font_importer_service.dart';
import 'package:defood/services/logs_service.dart';
import 'package:defood/services/paths_service.dart';
import 'package:defood/services/settings_service.dart';
import 'package:defood/services/updater_service.dart';
import 'package:defood/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:defood/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:defood/ui/views/boxes/boxes_view.dart';
import 'package:defood/ui/views/settings/settings_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: BoxesView),
    MaterialRoute(page: SettingsView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: CustomThemesService),
    InitializableSingleton(classType: SettingsService),
    LazySingleton(classType: PathsService),
    LazySingleton(classType: LogsService),
    LazySingleton(classType: UpdaterService),
    LazySingleton(classType: FontImporterService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
