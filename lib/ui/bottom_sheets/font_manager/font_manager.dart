import 'package:defood/ui/bottom_sheets/font_manager/font_manager_model.dart';
import 'package:defood/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

Future<T?> showFontManagerSheet<T>() {
  return showModalBottomSheet<T>(
    useSafeArea: true,
    useRootNavigator: true,
    context: StackedService.navigatorKey!.currentContext!,
    builder: (context) {
      return ViewModelBuilder.reactive(
        viewModelBuilder: () => FontManagerModel(),
        onViewModelReady: (viewModel) => viewModel.getFontList(),
        builder: (context, viewModel, child) {
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Manage custom fonts',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalSpaceMedium,
                const Text(
                  'Font will be properly applied after app restart',
                ),
                verticalSpaceMedium,
                Expanded(
                  child: ListView(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAlias,
                        surfaceTintColor: Theme.of(context).colorScheme.primary,
                        child: ListTile(
                          onTap: () => viewModel.pickFont('Default'),
                          title: const Text('Default (Inter Tight)'),
                          leading: viewModel.pickedFont == 'Default'
                              ? const Icon(Icons.check)
                              : null,
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        surfaceTintColor: Theme.of(context).colorScheme.primary,
                        child: ListTile(
                          onTap: () => viewModel.pickFont('System'),
                          title: const Text('System'),
                          leading: viewModel.pickedFont == 'System'
                              ? const Icon(Icons.check)
                              : null,
                        ),
                      ),
                      for (final font in viewModel.fontsList)
                        Card(
                          clipBehavior: Clip.antiAlias,
                          surfaceTintColor:
                              Theme.of(context).colorScheme.primary,
                          child: ListTile(
                            onTap: () => viewModel.pickFont(font),
                            title: Text(font),
                            leading: viewModel.pickedFont == font
                                ? const Icon(Icons.check)
                                : null,
                            trailing: IconButton(
                              onPressed: () => viewModel.deleteFont(font),
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
