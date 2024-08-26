import 'package:defood/gen/strings.g.dart';
import 'package:defood/ui/theme/theme_builder.dart';
import 'package:defood/utils/envs.dart';
import 'package:flutter/material.dart';
import 'package:defood/app/app.dialogs.dart';
import 'package:defood/app/app.locator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLogs.initLogs(
    logLevelsEnabled: [
      LogLevel.ERROR,
      LogLevel.WARNING,
      LogLevel.SEVERE,
      LogLevel.INFO
    ],
    directoryStructure: DirectoryStructure.SINGLE_FILE_FOR_DAY,
    timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE_2,
    logFileExtension: LogFileExtension.TXT,
  );
  LocaleSettings.setLocale(AppLocale.en);
  await Supabase.initialize(
    url: Env.apiUrl,
    anonKey: Env.apiKey,
  );
  await setupLocator();
  setupDialogUi();
  runApp(TranslationProvider(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: false,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top],
    );

    return const ThemeBuilder();
  }
}
