import 'package:defood/app/app.locator.dart';
import 'package:defood/app/app.snackbar.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

mixin SnackbarHelper on ChangeNotifier {
  final _snackbar = locator<SnackbarService>();

  void showInfoSnack(String message) {
    _snackbar.showCustomSnackBar(
      message: message,
      variant: SnackbarType.info,
    );
  }

  void showProgressSnack(String message) {
    _snackbar.showCustomSnackBar(
      message: message,
      variant: SnackbarType.progress,
    );
  }
}
