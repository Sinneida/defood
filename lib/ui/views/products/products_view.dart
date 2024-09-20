import 'package:defood/models/product.dart';
import 'package:defood/ui/views/products/widgets/product_card.dart';
import 'package:defood/ui/widgets/common/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'products_viewmodel.dart';

class ProductsView extends StackedView<ProductsViewModel> {
  const ProductsView({
    super.key,
    this.isDetailsView = false,
    this.products,
  });

  final bool isDetailsView;
  final List<ProductModel>? products;

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
      floatingActionButton: isDetailsView
          ? FloatingActionButton.extended(
              onPressed: viewModel.showCamera,
              label: const Text('Scan new'),
              icon: const Icon(Icons.barcode_reader),
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
