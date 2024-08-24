import 'package:defood/ui/views/settings/items/about_app/about_app.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'settings_viewmodel.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SettingsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            expandedHeight: 90,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(bottom: 16, left: 20),
              title: Text('Settings'),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              ListView(
                padding: const EdgeInsets.only(bottom: 30),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  AboutApp(),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SettingsViewModel();
}
