import 'package:defood/models/product.dart';
import 'package:defood/ui/views/products/widgets/product_card.dart';
import 'package:defood/ui/widgets/common/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:stacked/stacked.dart';

import 'products_viewmodel.dart';

class ProductsView extends StackedView<ProductsViewModel> {
  const ProductsView({
    super.key,
    required this.isDetailsView,
    this.products,
  });

  final bool isDetailsView;
  final List<Product>? products;

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
      bottomNavigationBar: isDetailsView
          ? BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () => viewModel.showCamera(),
                    icon: const Icon(Icons.barcode_reader),
                    label: const Text('Scan'),
                  ),
                  TextButton.icon(
                    onPressed: () => viewModel.showAddProduct(),
                    icon: const Icon(Icons.add_box),
                    label: const Text('Add manually'),
                  ),
                ],
              ),
            )
          : null,
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: !isDetailsView
          ? ExpandableFab(
              key: UniqueKey(),
              type: ExpandableFabType.up,
              childrenAnimation: ExpandableFabAnimation.none,
              distance: 70,
              overlayStyle: ExpandableFabOverlayStyle(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
              ),
              children: [
                Row(
                  children: [
                    const Text('Scan'),
                    const SizedBox(width: 20),
                    FloatingActionButton.small(
                      heroTag: null,
                      onPressed: () => viewModel.showCamera(),
                      child: const Icon(Icons.barcode_reader),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Add manually'),
                    const SizedBox(width: 20),
                    FloatingActionButton.small(
                      heroTag: null,
                      onPressed: () => viewModel.showAddProduct(),
                      child: const Icon(Icons.add_box),
                    ),
                  ],
                ),
              ],
            )
          : null,
    );
  }

  @override
  ProductsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProductsViewModel();

  @override
  void onViewModelReady(ProductsViewModel viewModel) {
    if (!isDetailsView) {
      viewModel.loadAllProducts();
      return;
    }
    viewModel.products = products!;
  }
}
