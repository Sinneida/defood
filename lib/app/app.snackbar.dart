import 'package:defood/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

enum SnackbarType { info, progress }

void setupSnackbarUi(Color snackColor, Color textColor) {
  final snackbar = locator<SnackbarService>();

  snackbar.registerCustomSnackbarConfig(
    variant: SnackbarType.info,
    config: SnackbarConfig(
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: snackColor,
      textColor: textColor,
      closeSnackbarOnMainButtonTapped: true,
      snackStyle: SnackStyle.GROUNDED,
      dismissDirection: DismissDirection.horizontal,
      isDismissible: true,
    ),
  );

  snackbar.registerCustomSnackbarConfig(
    variant: SnackbarType.progress,
    config: SnackbarConfig(
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: snackColor,
      textColor: textColor,
      closeSnackbarOnMainButtonTapped: true,
      snackStyle: SnackStyle.GROUNDED,
      dismissDirection: DismissDirection.horizontal,
      isDismissible: true,
      showProgressIndicator: true,
    ),
  );
}
