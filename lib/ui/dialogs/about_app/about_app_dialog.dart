import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'about_app_dialog_model.dart';

class AboutAppDialog extends StackedView<AboutAppDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const AboutAppDialog({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget builder(
    BuildContext context,
    AboutAppDialogModel viewModel,
    Widget? child,
  ) {
    return AboutDialog(
      applicationName: 'DeFood',
      applicationVersion: viewModel.version,
      // TODO: Enable when icon is created
      // applicationIcon: const CircleAvatar(
      //   radius: 28,
      //   backgroundImage: AssetImage('assets/icon/glassdown.png'),
      // ),
      children: [
        Text.rich(
          TextSpan(
            text: viewModel.message,
          ),
        ),
      ],
    );
  }

  @override
  AboutAppDialogModel viewModelBuilder(BuildContext context) =>
      AboutAppDialogModel();

  @override
  void onViewModelReady(AboutAppDialogModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.getPackageInfo();
  }
}
