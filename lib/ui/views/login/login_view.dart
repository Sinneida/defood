import 'package:defood/app/app.snackbar.dart';
import 'package:defood/gen/strings.g.dart';
import 'package:defood/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final snackColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).colorScheme.onPrimary;
    setupSnackbarUi(snackColor, textColor);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/food.svg',
                    height: 182,
                  ),
                  verticalSpaceSmall,
                  ListTile(
                    title: Text(
                      'DeFood',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                        fontSize:
                            Theme.of(context).textTheme.displayMedium?.fontSize,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.pattaya().fontFamily,
                      ),
                    ),
                  ),
                  // verticalSpaceTiny,
                  const ListTile(
                    title: Text(
                      'Simplify your food management!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  verticalSpaceMedium,
                  if (viewModel.logginIn)
                    Row(
                      children: [
                        Expanded(
                          child: Card.outlined(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 24,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 64,
                                    width: 64,
                                    child: CircularProgressIndicator(),
                                  ),
                                  verticalSpaceMedium,
                                  Text(
                                    'Logging in...',
                                    style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.fontSize,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
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
                                  onTap: () => viewModel.signIn(),
                                  leading: const Icon(Icons.login),
                                  title: const Text('Log in'),
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

  @override
  void onViewModelReady(LoginViewModel viewModel) {
    viewModel.signIn();
  }
}
