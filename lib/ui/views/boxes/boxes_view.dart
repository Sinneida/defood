import 'package:defood/ui/widgets/common/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'boxes_viewmodel.dart';

class BoxesView extends StackedView<BoxesViewModel> {
  const BoxesView({Key? key}) : super(key: key);

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
