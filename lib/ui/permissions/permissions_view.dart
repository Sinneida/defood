import 'package:defood/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'permissions_viewmodel.dart';

class PermissionsView extends StackedView<PermissionsViewModel> {
  const PermissionsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    PermissionsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              pinned: true,
              expandedHeight: 90,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(bottom: 16, left: 20),
                title: Text(
                  'Permissions',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card.outlined(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(viewModel.description),
                            ),
                            verticalSpaceTiny,
                            Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 1,
                              child: ListTile(
                                onTap: () => viewModel.requestInstallPermission(),
                                title: const Text('Install packages'),
                                subtitle: const Text(
                                  'Install newer version of this app from GitHub',
                                ),
                                tileColor: !viewModel.install
                                    ? Theme.of(context)
                                        .colorScheme
                                        .surfaceTint
                                        .withAlpha(20)
                                    : Colors.lightGreenAccent.withAlpha(40),
                                trailing: !viewModel.install
                                    ? const Icon(
                                        Icons.close,
                                        color: Colors.redAccent,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                              ),
                            ),
                            verticalSpaceTiny,
                            Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 1,
                              child: ListTile(
                                onTap: () => viewModel.requestUpdatesPermission(),
                                title: const Text('Disable updates prompting'),
                                subtitle: const Text(
                                  'Don\'t show that update is available',
                                ),
                                tileColor: !viewModel.updates
                                    ? Theme.of(context)
                                        .colorScheme
                                        .surfaceTint
                                        .withAlpha(20)
                                    : Colors.lightGreenAccent.withAlpha(40),
                                trailing: !viewModel.updates
                                    ? const Icon(
                                        Icons.close,
                                        color: Colors.redAccent,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                              ),
                            ),
                            verticalSpaceSmall,
                            Row(
                              children: [
                                Expanded(
                                  child: FilledButton(
                                    onPressed: () => viewModel.goHome(),
                                    child: const Text('Finish'),
                                  ),
                                ),
                              ],
                            )
                            // if (viewModel.storage)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  @override
  PermissionsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PermissionsViewModel();

  @override
  void onViewModelReady(PermissionsViewModel viewModel) {
    viewModel.init();
  }
}
