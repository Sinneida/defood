import 'package:defood/ui/views/products/widgets/product_card.dart';
import 'package:defood/ui/widgets/common/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            expandedHeight: 90,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(bottom: 16, left: 20),
              title: Text('Products'),
            ),
          ),
          if (viewModel.isBusy)
            const SliverToBoxAdapter(
              child: LinearProgressIndicator(),
            )
          else if (viewModel.products.isEmpty)
            const PlaceholderText(
              text: ['No products 😔', 'You can add new one below!'],
            )
          else
            SliverList.list(
              children: [
                ListView(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (final product in viewModel.products)
                      ProductCard(
                        product,
                      )
                  ],
                )
              ],
            )
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: UniqueKey(),
        type: ExpandableFabType.up,
        childrenAnimation: ExpandableFabAnimation.none,
        distance: 70,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
        ),
        children: const [
          Row(
            children: [
              Text('Scan'),
              SizedBox(width: 20),
              FloatingActionButton.small(
                heroTag: null,
                onPressed: null,
                child: Icon(Icons.barcode_reader),
              ),
            ],
          ),
          Row(
            children: [
              Text('Add manually'),
              SizedBox(width: 20),
              FloatingActionButton.small(
                heroTag: null,
                onPressed: null,
                child: Icon(Icons.add_box),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  ProductsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProductsViewModel();

  @override
  void onViewModelReady(ProductsViewModel viewModel) {
    viewModel.loadAllProducts();
  }
}
