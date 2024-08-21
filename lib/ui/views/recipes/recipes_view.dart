import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'recipes_viewmodel.dart';

class RecipesView extends StackedView<RecipesViewModel> {
  const RecipesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RecipesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  RecipesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RecipesViewModel();
}
