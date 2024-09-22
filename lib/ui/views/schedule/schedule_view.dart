import 'package:defood/ui/widgets/common/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'schedule_viewmodel.dart';

class ScheduleView extends StackedView<ScheduleViewModel> {
  const ScheduleView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ScheduleViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 90,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(bottom: 16, left: 20),
              title: Text('Schedule'),
            ),
          ),
          PlaceholderText(
            text: ['No schedule 😔', 'You can add new one below!'],
          )
        ],
      ),
    );
  }

  @override
  ScheduleViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ScheduleViewModel();
}
