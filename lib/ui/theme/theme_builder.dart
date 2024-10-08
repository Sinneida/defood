import 'package:defood/app/app.router.dart';
import 'package:defood/app/app.snackbar.dart';
import 'package:defood/gen/strings.g.dart';
import 'package:defood/ui/theme/theme_builder_model.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:defood/utils/dynamic_color_fix.dart';

class ThemeBuilder extends StackedView<ThemeBuilderModel> {
  const ThemeBuilder({super.key});

  void setupSnackbar(BuildContext context, ColorScheme light, ColorScheme dark) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final Color snackColor = isLightTheme ? dark.primary : light.primary;
    final Color textColor = isLightTheme ? dark.onPrimary : light.onPrimary;
    setupSnackbarUi(snackColor, textColor);
  }

  @override
  Widget builder(BuildContext context, viewModel, Widget? child) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        final monetPresent = lightDynamic != null && darkDynamic != null;

        if (monetPresent && viewModel.monetEnabled) {
          lightScheme = generateColorScheme(lightDynamic.primary);
          darkScheme = generateColorScheme(darkDynamic.primary, Brightness.dark);
        } else {
          lightScheme = viewModel.getTheme(viewModel.customTheme).lightScheme;
          darkScheme = viewModel.getTheme(viewModel.customTheme).darkScheme;
        }

        setupSnackbar(context, lightScheme, darkScheme);

        return MaterialApp(
          title: 'GlassDown',
          themeMode: viewModel.themeMode,
          theme: ThemeData(
            colorScheme: lightScheme,
            useMaterial3: true,
            fontFamily: viewModel.useImportedFont
                ? 'CustomFont'
                : GoogleFonts.gabarito().fontFamily,
          ),
          darkTheme: ThemeData(
            colorScheme: darkScheme,
            useMaterial3: true,
            fontFamily: viewModel.useImportedFont
                ? 'CustomFont'
                : GoogleFonts.gabarito().fontFamily,
          ),
          initialRoute:
              viewModel.shownPermissions ? Routes.loginView : Routes.permissionsView,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [
            StackedService.routeObserver,
          ],
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
        );
      },
    );
  }

  @override
  viewModelBuilder(BuildContext context) {
    return ThemeBuilderModel();
  }

  @override
  void onViewModelReady(ThemeBuilderModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.loadCustomFont();
  }
}
