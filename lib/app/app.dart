import 'package:defood/services/auth_service.dart';
import 'package:defood/services/custom_themes_service.dart';
import 'package:defood/services/database_service.dart';
import 'package:defood/services/font_importer_service.dart';
import 'package:defood/services/logs_service.dart';
import 'package:defood/services/off_service.dart';
import 'package:defood/services/paths_service.dart';
import 'package:defood/services/settings/about_settings_service.dart';
import 'package:defood/services/settings/appearance_settings_service.dart';
import 'package:defood/services/settings/auth_settings_service.dart';
import 'package:defood/services/settings/base/settings_service.dart';
import 'package:defood/services/updater_service.dart';
import 'package:defood/ui/permissions/permissions_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:defood/ui/views/boxes/boxes_view.dart';
import 'package:defood/ui/views/settings/settings_view.dart';
import 'package:defood/ui/views/navigation/navigation_view.dart';
import 'package:defood/ui/views/recipes/recipes_view.dart';
import 'package:defood/ui/views/schedule/schedule_view.dart';
import 'package:defood/ui/dialogs/about_app/about_app_dialog.dart';
import 'package:defood/ui/views/login/login_view.dart';
import 'package:defood/ui/dialogs/add_box/add_box_dialog.dart';
import 'package:defood/ui/views/products/products_view.dart';
import 'package:defood/ui/views/box_details/box_details_view.dart';
import 'package:defood/ui/views/camera/camera_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: BoxesView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: NavigationView),
    MaterialRoute(page: RecipesView),
    MaterialRoute(page: ScheduleView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: PermissionsView),
    MaterialRoute(page: ProductsView),
    MaterialRoute(page: BoxDetailsView),
    MaterialRoute(page: CameraView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: CustomThemesService),
    InitializableSingleton(classType: SettingsService),
    InitializableSingleton(classType: AppearanceSettingsService),
    InitializableSingleton(classType: AboutSettingsService),
    InitializableSingleton(classType: AuthSettingsService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: PathsService),
    LazySingleton(classType: LogsService),
    LazySingleton(classType: UpdaterService),
    LazySingleton(classType: FontImporterService),
    LazySingleton(classType: DatabaseService),
    LazySingleton(classType: OpenFoodFactsService),
// @stacked-service
  ],
  dialogs: [
    StackedDialog(classType: AboutAppDialog),
    StackedDialog(classType: AddBoxDialog),
// @stacked-dialog
  ],
)
class App {}
