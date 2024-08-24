import 'package:defood/services/custom_themes_service.dart';
import 'package:defood/services/font_importer_service.dart';
import 'package:defood/services/logs_service.dart';
import 'package:defood/services/paths_service.dart';
import 'package:defood/services/settings/about_settings_service.dart';
import 'package:defood/services/settings/appearance_settings_service.dart';
import 'package:defood/services/settings/base/settings_service.dart';
import 'package:defood/services/updater_service.dart';
import 'package:defood/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:defood/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:defood/ui/views/boxes/boxes_view.dart';
import 'package:defood/ui/views/settings/settings_view.dart';
import 'package:defood/ui/views/navigation/navigation_view.dart';
import 'package:defood/ui/views/recipes/recipes_view.dart';
import 'package:defood/ui/views/schedule/schedule_view.dart';
import 'package:defood/ui/dialogs/about_app/about_app_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: BoxesView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: NavigationView),
    MaterialRoute(page: RecipesView),
    MaterialRoute(page: ScheduleView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: CustomThemesService),
    InitializableSingleton(classType: SettingsService),
    InitializableSingleton(classType: AppearanceSettingsService),
    InitializableSingleton(classType: AboutSettingsService),
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
    StackedDialog(classType: AboutAppDialog),
// @stacked-dialog
  ],
)
class App {}
