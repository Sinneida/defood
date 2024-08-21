import 'package:defood/ui/widgets/common/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'boxes_viewmodel.dart';

class BoxesView extends StackedView<BoxesViewModel> {
  const BoxesView({Key? key}) : super(key: key);

  // Widget getViewForIndex(int index) {
  //   switch (index) {
  //     case 0:
  //       return const AppsView();
  //     case 1:
  //       return const SettingsView();
  //     default:
  //       return const AppsView();
  //   }
  // }

  @override
  Widget builder(
    BuildContext context,
    BoxesViewModel viewModel,
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
              title: Text('Boxes'),
            ),
          ),
          PlaceholderText(
            text: ['No boxes 😔', 'You can add new one below!'],
          )
        ],
      ),
    );
  }

  @override
  BoxesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BoxesViewModel();
}
