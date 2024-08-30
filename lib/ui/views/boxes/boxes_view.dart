import 'package:defood/ui/widgets/common/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:defood/gen/strings.g.dart';

import 'boxes_viewmodel.dart';

class BoxesView extends StackedView<BoxesViewModel> {
  const BoxesView({super.key});

  @override
  Widget builder(
    BuildContext context,
    BoxesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 90,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(bottom: 16, left: 20),
              title: Text(t.boxes.name),
            ),
            actions: [
              if (viewModel.avatar == null)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_circle),
                  padding: const EdgeInsets.only(right: 12),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(viewModel.avatar!),
                  ),
                )
            ],
          ),
          PlaceholderText(
            text: [
              t.boxes.no_boxes_placeholder_1,
              t.boxes.no_boxes_placeholder_2,
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(t.boxes.add_box),
        icon: const Icon(Icons.add),
      ),
    );
  }

  @override
  BoxesViewModel viewModelBuilder(BuildContext context) => BoxesViewModel();

  @override
  void onViewModelReady(BoxesViewModel viewModel) {
    if (viewModel.hasSignedIn) {
      viewModel.signIn();
    }
  }
}
