import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'schedule_viewmodel.dart';

class ScheduleView extends StackedView<ScheduleViewModel> {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ScheduleViewModel viewModel,
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
  ScheduleViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ScheduleViewModel();
}
