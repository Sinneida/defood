import 'package:defood/gen/strings.g.dart';
import 'package:defood/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
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
                'Login',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card.outlined(
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                t.login.description,
                              ),
                            ),
                            verticalSpaceTiny,
                            Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 1,
                              child: ListTile(
                                onTap: () => viewModel.signInWithGoogle(),
                                leading: const Icon(Icons.login),
                                title: Text(t.login.login_button),
                              ),
                            ),
                            verticalSpaceTiny,
                            Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 1,
                              child: ListTile(
                                onTap: () => viewModel.signOut(),
                                leading: const Icon(Icons.logout),
                                title: const Text('Log out'),
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
