import 'package:defood/app/app.locator.dart';
import 'package:defood/app/app.snackbar.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

mixin NotificationHelper on ChangeNotifier {
  final _snackbar = locator<SnackbarService>();

  void notifyInfo(String message) {
    _snackbar.showCustomSnackBar(
      message: message,
      variant: SnackbarType.info,
    );
  }

  void notifyError(String message) {
    _snackbar.showCustomSnackBar(
      message: message,
      variant: SnackbarType.error,
    );
  }

  void notifyProgress(String message) {
    _snackbar.showCustomSnackBar(
      message: message,
      variant: SnackbarType.progress,
    );
  }
}
