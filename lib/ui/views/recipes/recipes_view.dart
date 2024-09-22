import 'package:defood/ui/widgets/common/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'recipes_viewmodel.dart';

class RecipesView extends StackedView<RecipesViewModel> {
  const RecipesView({super.key});

  @override
  Widget builder(
    BuildContext context,
    RecipesViewModel viewModel,
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
              title: Text('Recipes'),
            ),
          ),
          PlaceholderText(
            text: ['No recipes 😔', 'You can add new one below!'],
          )
        ],
      ),
    );
  }

  @override
  RecipesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RecipesViewModel();
}
