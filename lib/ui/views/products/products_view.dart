import 'package:defood/ui/widgets/common/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'products_viewmodel.dart';

class ProductsView extends StackedView<ProductsViewModel> {
  const ProductsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ProductsViewModel viewModel,
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
              title: Text('Products'),
            ),
          ),
          PlaceholderText(
            text: ['No products 😔', 'You can add new one below!'],
          )
        ],
      ),
    );
  }

  @override
  ProductsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProductsViewModel();
}
