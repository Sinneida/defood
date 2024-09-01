import 'package:defood/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

enum SnackbarType { info, progress, error }

void setupSnackbarUi(Color snackColor, Color textColor) {
  final snackbar = locator<SnackbarService>();

  snackbar.registerCustomSnackbarConfig(
    variant: SnackbarType.info,
    config: SnackbarConfig(
      snackPosition: SnackPosition.TOP,
      backgroundColor: snackColor,
      textColor: textColor,
      closeSnackbarOnMainButtonTapped: true,
      snackStyle: SnackStyle.FLOATING,
      dismissDirection: DismissDirection.horizontal,
      isDismissible: true,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: 25,
    ),
  );

  snackbar.registerCustomSnackbarConfig(
    variant: SnackbarType.error,
    config: SnackbarConfig(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      icon: const Icon(
        Icons.error_outline,
        color: Colors.white,
      ),
      shouldIconPulse: false,
      titleText: const Text('Error'),
      textColor: Colors.white,
      closeSnackbarOnMainButtonTapped: true,
      snackStyle: SnackStyle.FLOATING,
      dismissDirection: DismissDirection.horizontal,
      isDismissible: true,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: 25,
    ),
  );

  snackbar.registerCustomSnackbarConfig(
    variant: SnackbarType.progress,
    config: SnackbarConfig(
      snackPosition: SnackPosition.TOP,
      backgroundColor: snackColor,
      textColor: textColor,
      closeSnackbarOnMainButtonTapped: true,
      snackStyle: SnackStyle.FLOATING,
      dismissDirection: DismissDirection.horizontal,
      isDismissible: true,
      showProgressIndicator: true,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: 25,
    ),
  );
}
