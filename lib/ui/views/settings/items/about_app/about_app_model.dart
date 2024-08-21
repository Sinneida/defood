import 'package:defood/app/app.locator.dart';
import 'package:defood/app/app.snackbar.dart';
import 'package:defood/services/settings_service.dart';
import 'package:defood/utils/envs.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppModel extends ReactiveViewModel {
  final _dialogService = locator<DialogService>();
  final _settings = locator<SettingsService>();
  final _snackbar = locator<SnackbarService>();

  bool get devOptions => _settings.devOptions;
  bool get isRepoUrlDisabled => Env.repoUrl.isEmpty;

  final loadingMsg = 'Loading...';
  AppPackageInfo? _info;
  AppPackageInfo? get info => _info;

  String get name => info?.appName ?? loadingMsg;
  String get version => info?.version ?? loadingMsg;
  String get buildNumber => info?.buildNumber ?? loadingMsg;

  Future<void> openGitHub() async {
    await launchUrl(Uri.parse(Env.repoUrl));
  }

  Future<void> setDevOptions(bool val) async {
    _settings.setPref<bool>(SettingsKey.devOptions, val);
    await _snackbar.showCustomSnackBar(
      message: getDevOptionsSnackMessage(),
      variant: SnackbarType.info,
    );
  }

  String getDevOptionsSnackMessage() {
    if (devOptions) {
      return "You've enabled developer options. Please be careful with it!";
    } else {
      return 'Developer options disabled.';
    }
  }

  Future<void> getPackageInfo() async {
    _info = await _settings.getPackageInfo();
    rebuildUi();
  }

  Future<void> showAboutDialog() async {
    // try {
    //   await _dialogService.showCustomDialog<void, void>(
    //     variant: DialogType.aboutApp,
    //     barrierDismissible: true,
    //   );
    //   rebuildUi();
    // } catch (e) {
    //   _snackbar.showCustomSnackBar(
    //     variant: SnackbarType.info,
    //     message: e.toString(),
    //   );
    // }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_settings];
}
