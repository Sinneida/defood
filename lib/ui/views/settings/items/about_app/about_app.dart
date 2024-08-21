import 'package:defood/ui/widgets/settings/common/item_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import 'about_app_model.dart';

class AboutApp extends StackedView<AboutAppModel> {
  const AboutApp({super.key});

  @override
  Widget builder(
    BuildContext context,
    AboutAppModel viewModel,
    Widget? child,
  ) {
    return InkWell(
      onTap: () => viewModel.showAboutDialog(),
      onLongPress: () => viewModel.setDevOptions(!viewModel.devOptions),
      child: ItemWrapper(
        mainText: 'About',
        secondaryText: 'Version: ${viewModel.version}',
        trailingWidget: viewModel.isRepoUrlDisabled
            ? null
            : FilledButton.tonalIcon(
                icon: SvgPicture.asset(
                  'assets/github/github.svg',
                  height: 18,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () => viewModel.openGitHub(),
                label: const Text('GitHub'),
              ),
      ),
    );
  }

  @override
  AboutAppModel viewModelBuilder(
    BuildContext context,
  ) =>
      AboutAppModel();

  @override
  void onViewModelReady(AboutAppModel viewModel) {
    viewModel.getPackageInfo();
    super.onViewModelReady(viewModel);
  }
}
