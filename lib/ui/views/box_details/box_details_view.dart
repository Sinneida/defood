import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'box_details_viewmodel.dart';

class BoxDetailsView extends StackedView<BoxDetailsViewModel> {
  const BoxDetailsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BoxDetailsViewModel viewModel,
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
  BoxDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BoxDetailsViewModel();
}
