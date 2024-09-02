import 'package:defood/ui/views/settings/items/about_app/about_app.dart';
import 'package:defood/ui/views/settings/items/app_theme/app_theme.dart';
import 'package:defood/ui/views/settings/items/check_updates/check_updates.dart';
import 'package:defood/ui/views/settings/items/custom_font_list/custom_font_list.dart';
import 'package:defood/ui/views/settings/items/custom_theme/custom_theme.dart';
import 'package:defood/ui/views/settings/items/delete_logs/delete_logs.dart';
import 'package:defood/ui/views/settings/items/export_logs/export_logs.dart';
import 'package:defood/ui/views/settings/items/import_font/import_font.dart';
import 'package:defood/ui/views/settings/items/monet_theme/monet_theme.dart';
import 'package:defood/ui/views/settings/items/show_logs/show_logs.dart';
import 'package:defood/ui/views/settings/items/show_permissions/show_permissions.dart';
import 'package:defood/ui/views/settings/items/user_card/user_card.dart';
import 'package:defood/ui/widgets/common/divider.dart';
import 'package:defood/ui/widgets/settings/common/group_header.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'settings_viewmodel.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  const SettingsView({super.key});

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
                  UserCard(),
                  GroupHeader(name: 'Appearance'),
                  AppTheme(),
                  MonetTheme(),
                  CustomTheme(),
                  ImportFont(),
                  CustomFontList(),
                  ItemDivider(),
                  GroupHeader(name: 'Logs'),
                  ShowLogs(),
                  ExportLogs(),
                  DeleteLogs(),
                  ItemDivider(),
                  GroupHeader(name: 'About'),
                  ShowPermissions(),
                  CheckUpdates(),
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
